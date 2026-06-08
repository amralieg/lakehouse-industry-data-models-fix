-- Metric views for domain: product | Business: Agriculture | Version: 1 | Generated on: 2026-05-01 18:41:06

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`product_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic product master KPIs covering portfolio composition, organic and non-GMO positioning, cost benchmarks, and lifecycle health — used by product management and executive leadership to steer portfolio investment and compliance posture."
  source: "`agriculture_ecm`.`product`.`master`"
  dimensions:
    - name: "product_category"
      expr: product_category
      comment: "Top-level product category for portfolio segmentation (e.g., Grain, Produce, Protein)."
    - name: "product_type"
      expr: product_type
      comment: "Product type classification enabling cross-type performance comparison."
    - name: "product_line"
      expr: product_line
      comment: "Product line grouping for brand and line-level performance analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage (Active, Discontinued, Pending) to track portfolio health."
    - name: "organic_certified_flag"
      expr: organic_certified_flag
      comment: "Indicates whether the product holds organic certification, enabling organic vs. conventional split."
    - name: "non_gmo_flag"
      expr: non_gmo_flag
      comment: "Flags non-GMO products for market positioning and regulatory reporting."
    - name: "fsma_regulated_flag"
      expr: fsma_regulated_flag
      comment: "Identifies FSMA-regulated products for food safety compliance tracking."
    - name: "packaging_type"
      expr: packaging_type
      comment: "Packaging format dimension for supply chain and sustainability analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of product effective date for launch trend analysis."
    - name: "discontinuation_date_month"
      expr: DATE_TRUNC('MONTH', discontinuation_date)
      comment: "Month of product discontinuation for portfolio attrition trend analysis."
  measures:
    - name: "total_active_products"
      expr: COUNT(CASE WHEN lifecycle_status = 'Active' THEN master_id END)
      comment: "Count of currently active products in the portfolio. Executives use this to gauge portfolio breadth and growth trajectory."
    - name: "total_organic_certified_products"
      expr: COUNT(CASE WHEN organic_certified_flag = TRUE THEN master_id END)
      comment: "Number of organic-certified products. Tracks organic portfolio expansion, a key strategic and premium-pricing lever."
    - name: "organic_certification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN organic_certified_flag = TRUE THEN master_id END) / NULLIF(COUNT(master_id), 0), 2)
      comment: "Percentage of total products that are organic-certified. Informs organic market share strategy and investment prioritisation."
    - name: "non_gmo_product_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN non_gmo_flag = TRUE THEN master_id END) / NULLIF(COUNT(master_id), 0), 2)
      comment: "Percentage of products with non-GMO designation. Tracks non-GMO portfolio positioning for consumer and retailer demand."
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost across products. Benchmarks cost structure for pricing and margin management decisions."
    - name: "avg_net_weight_kg"
      expr: AVG(CAST(net_weight_kg AS DOUBLE))
      comment: "Average net weight per product unit in kilograms. Supports logistics cost modelling and packaging optimisation."
    - name: "total_discontinued_products"
      expr: COUNT(CASE WHEN lifecycle_status = 'Discontinued' THEN master_id END)
      comment: "Count of discontinued products. Monitors portfolio rationalisation pace and SKU reduction initiatives."
    - name: "fsma_regulated_product_count"
      expr: COUNT(CASE WHEN fsma_regulated_flag = TRUE THEN master_id END)
      comment: "Number of products subject to FSMA regulation. Critical for food safety compliance risk management and audit readiness."
    - name: "avg_mrl_threshold_ppm"
      expr: AVG(CAST(mrl_threshold_ppm AS DOUBLE))
      comment: "Average maximum residue limit threshold (ppm) across products. Monitors agrochemical residue risk exposure at the portfolio level."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`product_agrochemical_product`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Agrochemical product portfolio KPIs covering regulatory compliance, toxicity risk, organic eligibility, and application rate benchmarks — used by regulatory affairs, agronomy, and supply chain leadership."
  source: "`agriculture_ecm`.`product`.`agrochemical_product`"
  dimensions:
    - name: "product_type"
      expr: product_type
      comment: "Type of agrochemical product (Herbicide, Fungicide, Insecticide, etc.) for portfolio segmentation."
    - name: "product_status"
      expr: product_status
      comment: "Current registration/commercial status of the agrochemical product."
    - name: "formulation_type"
      expr: formulation_type
      comment: "Formulation category (e.g., Emulsifiable Concentrate, Wettable Powder) for supply and application analysis."
    - name: "epa_toxicity_category"
      expr: epa_toxicity_category
      comment: "EPA toxicity classification (I–IV) for risk stratification and regulatory reporting."
    - name: "organic_approved_flag"
      expr: organic_approved_flag
      comment: "Indicates OMRI/organic-approved status, enabling organic-eligible product tracking."
    - name: "restricted_use_flag"
      expr: restricted_use_flag
      comment: "Flags restricted-use pesticides requiring certified applicator, critical for compliance monitoring."
    - name: "manufacturer_name"
      expr: manufacturer_name
      comment: "Manufacturer for supplier concentration and sourcing risk analysis."
    - name: "mode_of_action_code"
      expr: mode_of_action_code
      comment: "FRAC/HRAC/IRAC mode of action code for resistance management strategy."
    - name: "resistance_group"
      expr: resistance_group
      comment: "Resistance group classification for rotation planning and resistance risk management."
    - name: "label_approval_date_year"
      expr: YEAR(label_approval_date)
      comment: "Year of label approval for tracking regulatory approval pipeline trends."
  measures:
    - name: "total_registered_products"
      expr: COUNT(CASE WHEN product_status = 'Active' THEN agrochemical_product_id END)
      comment: "Count of actively registered agrochemical products. Tracks the size of the compliant product portfolio available for use."
    - name: "restricted_use_product_count"
      expr: COUNT(CASE WHEN restricted_use_flag = TRUE THEN agrochemical_product_id END)
      comment: "Number of restricted-use pesticide products. Drives certified applicator training requirements and compliance risk exposure."
    - name: "restricted_use_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN restricted_use_flag = TRUE THEN agrochemical_product_id END) / NULLIF(COUNT(agrochemical_product_id), 0), 2)
      comment: "Percentage of agrochemical products classified as restricted use. Informs regulatory risk posture and applicator certification investment."
    - name: "organic_approved_product_count"
      expr: COUNT(CASE WHEN organic_approved_flag = TRUE THEN agrochemical_product_id END)
      comment: "Number of organically approved agrochemical products. Supports organic production programme capacity planning."
    - name: "organic_approved_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN organic_approved_flag = TRUE THEN agrochemical_product_id END) / NULLIF(COUNT(agrochemical_product_id), 0), 2)
      comment: "Percentage of agrochemical products approved for organic use. Tracks organic input portfolio depth relative to total portfolio."
    - name: "avg_active_ingredient_concentration"
      expr: AVG(CAST(active_ingredient_concentration AS DOUBLE))
      comment: "Average active ingredient concentration across products. Benchmarks formulation strength for efficacy and safety comparisons."
    - name: "avg_max_application_rate"
      expr: AVG(CAST(max_application_rate AS DOUBLE))
      comment: "Average maximum application rate across registered products. Informs agronomic guidance and environmental load assessments."
    - name: "groundwater_advisory_product_count"
      expr: COUNT(CASE WHEN groundwater_advisory_flag = TRUE THEN agrochemical_product_id END)
      comment: "Number of products carrying a groundwater advisory. Quantifies environmental risk exposure for sustainability and regulatory reporting."
    - name: "distinct_resistance_groups"
      expr: COUNT(DISTINCT resistance_group)
      comment: "Number of distinct resistance groups represented in the portfolio. Measures resistance management diversity — a key agronomic risk KPI."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`product_commodity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commodity portfolio KPIs covering pricing benchmarks, organic eligibility, perishability risk, storage requirements, and yield potential — used by commodity trading, procurement, and supply chain leadership."
  source: "`agriculture_ecm`.`product`.`commodity`"
  dimensions:
    - name: "commodity_type"
      expr: commodity_type
      comment: "Commodity type (e.g., Grain, Oilseed, Vegetable) for portfolio segmentation."
    - name: "commodity_class"
      expr: commodity_class
      comment: "Commodity class for market and regulatory classification."
    - name: "commodity_status"
      expr: commodity_status
      comment: "Active/inactive status of the commodity for portfolio health monitoring."
    - name: "organic_eligible_flag"
      expr: organic_eligible_flag
      comment: "Flags commodities eligible for organic certification, enabling organic market sizing."
    - name: "perishable_flag"
      expr: perishable_flag
      comment: "Identifies perishable commodities requiring cold chain management."
    - name: "gmo_status"
      expr: gmo_status
      comment: "GMO classification of the commodity for market access and labelling compliance."
    - name: "fsma_covered_flag"
      expr: fsma_covered_flag
      comment: "Indicates FSMA coverage for food safety compliance segmentation."
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Country of origin for trade compliance, tariff, and COOL reporting."
    - name: "exchange_market"
      expr: exchange_market
      comment: "Exchange market (e.g., CBOT, CME) for commodity price benchmarking context."
    - name: "effective_date_year"
      expr: YEAR(effective_date)
      comment: "Year the commodity record became effective, for trend and vintage analysis."
  measures:
    - name: "total_active_commodities"
      expr: COUNT(CASE WHEN commodity_status = 'Active' THEN commodity_id END)
      comment: "Count of active commodities in the portfolio. Tracks tradeable commodity breadth for procurement and trading strategy."
    - name: "avg_benchmark_price"
      expr: AVG(CAST(benchmark_price AS DOUBLE))
      comment: "Average benchmark price across commodities. Provides a portfolio-level price reference for procurement cost management."
    - name: "avg_typical_yield_per_acre"
      expr: AVG(CAST(typical_yield_per_acre AS DOUBLE))
      comment: "Average typical yield per acre across commodities. Benchmarks productivity expectations for crop planning and land use decisions."
    - name: "perishable_commodity_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN perishable_flag = TRUE THEN commodity_id END) / NULLIF(COUNT(commodity_id), 0), 2)
      comment: "Percentage of commodities classified as perishable. Quantifies cold chain dependency and spoilage risk exposure across the portfolio."
    - name: "organic_eligible_commodity_count"
      expr: COUNT(CASE WHEN organic_eligible_flag = TRUE THEN commodity_id END)
      comment: "Number of commodities eligible for organic production. Informs organic market expansion capacity and premium revenue potential."
    - name: "avg_moisture_content_max_pct"
      expr: AVG(CAST(moisture_content_max_pct AS DOUBLE))
      comment: "Average maximum allowable moisture content across commodities. Drives storage condition standards and quality loss risk management."
    - name: "avg_test_weight_min_lbs_bu"
      expr: AVG(CAST(test_weight_min_lbs_bu AS DOUBLE))
      comment: "Average minimum test weight (lbs/bu) across commodities. Benchmarks quality floor standards for grading and contract compliance."
    - name: "fsma_covered_commodity_count"
      expr: COUNT(CASE WHEN fsma_covered_flag = TRUE THEN commodity_id END)
      comment: "Number of FSMA-covered commodities. Quantifies food safety regulatory scope for compliance programme resourcing."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`product_organic_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Organic certification programme KPIs covering certification status, acreage under certification, renewal pipeline health, and compliance flags — used by sustainability, regulatory affairs, and executive leadership to manage organic programme integrity."
  source: "`agriculture_ecm`.`product`.`organic_certification`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Current certification status (Active, Suspended, Revoked, Pending) for programme health segmentation."
    - name: "certifying_agent_name"
      expr: certifying_agent_name
      comment: "Name of the certifying agent for agent performance and concentration risk analysis."
    - name: "operation_type"
      expr: operation_type
      comment: "Type of certified operation (Crop, Livestock, Handler) for programme scope analysis."
    - name: "organic_label_type"
      expr: organic_label_type
      comment: "Organic label tier (100% Organic, Organic, Made with Organic) for premium positioning analysis."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for international organic equivalency and trade compliance analysis."
    - name: "international_equivalency_flag"
      expr: international_equivalency_flag
      comment: "Flags certifications with international equivalency recognition for export market access."
    - name: "gmo_free_flag"
      expr: gmo_free_flag
      comment: "Indicates GMO-free status within the organic certification for dual-claim product positioning."
    - name: "effective_date_year"
      expr: YEAR(effective_date)
      comment: "Year certification became effective for cohort and vintage trend analysis."
  measures:
    - name: "total_active_certifications"
      expr: COUNT(CASE WHEN certification_status = 'Active' THEN organic_certification_id END)
      comment: "Count of currently active organic certifications. Core KPI for organic programme scale and market access."
    - name: "total_certified_acreage"
      expr: SUM(CAST(certified_acreage AS DOUBLE))
      comment: "Total acreage under active organic certification. Measures organic land base — a primary indicator of organic production capacity."
    - name: "avg_certified_acreage"
      expr: AVG(CAST(certified_acreage AS DOUBLE))
      comment: "Average certified acreage per certification. Benchmarks operation size for programme investment and support allocation."
    - name: "suspended_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'Suspended' THEN organic_certification_id END)
      comment: "Number of suspended certifications. Tracks compliance failures and programme integrity risk — triggers immediate corrective action."
    - name: "revoked_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'Revoked' THEN organic_certification_id END)
      comment: "Number of revoked certifications. Measures serious compliance failures with direct impact on organic revenue and brand trust."
    - name: "certification_suspension_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN certification_status = 'Suspended' THEN organic_certification_id END) / NULLIF(COUNT(organic_certification_id), 0), 2)
      comment: "Percentage of certifications currently suspended. Executive-level compliance health indicator for the organic programme."
    - name: "premium_pricing_eligible_count"
      expr: COUNT(CASE WHEN premium_pricing_eligible_flag = TRUE THEN organic_certification_id END)
      comment: "Number of certifications eligible for organic premium pricing. Directly links certification portfolio to premium revenue opportunity."
    - name: "transition_complete_count"
      expr: COUNT(CASE WHEN transition_complete_flag = TRUE THEN organic_certification_id END)
      comment: "Number of operations that have completed organic transition. Tracks pipeline conversion from conventional to certified organic production."
    - name: "fsma_compliant_certification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fsma_compliant_flag = TRUE THEN organic_certification_id END) / NULLIF(COUNT(organic_certification_id), 0), 2)
      comment: "Percentage of organic certifications that are also FSMA compliant. Measures dual-compliance coverage critical for food safety regulatory risk."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`product_mrl_threshold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maximum Residue Limit (MRL) threshold KPIs covering regulatory coverage, tolerance levels, organic approvals, and import tolerance exposure — used by regulatory affairs, food safety, and trade compliance leadership."
  source: "`agriculture_ecm`.`product`.`mrl_threshold`"
  dimensions:
    - name: "jurisdiction_country_code"
      expr: jurisdiction_country_code
      comment: "Regulatory jurisdiction country for market-specific MRL compliance analysis."
    - name: "tolerance_status"
      expr: tolerance_status
      comment: "Current status of the MRL tolerance (Active, Revoked, Pending) for compliance currency tracking."
    - name: "tolerance_type"
      expr: tolerance_type
      comment: "Type of tolerance (e.g., Established, Exemption, Import) for regulatory classification."
    - name: "organic_approved_flag"
      expr: organic_approved_flag
      comment: "Flags MRL thresholds applicable to organic production for organic compliance analysis."
    - name: "import_tolerance_flag"
      expr: import_tolerance_flag
      comment: "Identifies import-specific tolerances for trade compliance and market access risk management."
    - name: "default_mrl_flag"
      expr: default_mrl_flag
      comment: "Flags default MRL entries used when no specific tolerance is established."
    - name: "commodity_group"
      expr: commodity_group
      comment: "Commodity group for cross-commodity MRL coverage analysis."
    - name: "mode_of_action_code"
      expr: mode_of_action_code
      comment: "Mode of action code for resistance management and regulatory grouping."
    - name: "effective_date_year"
      expr: YEAR(effective_date)
      comment: "Year MRL threshold became effective for regulatory change trend analysis."
  measures:
    - name: "total_active_mrl_thresholds"
      expr: COUNT(CASE WHEN tolerance_status = 'Active' THEN mrl_threshold_id END)
      comment: "Count of active MRL thresholds. Measures regulatory coverage breadth — gaps indicate unregistered use risk."
    - name: "avg_mrl_value_ppm"
      expr: AVG(CAST(mrl_value_ppm AS DOUBLE))
      comment: "Average MRL value in parts per million across thresholds. Benchmarks residue tolerance stringency for risk and compliance planning."
    - name: "avg_limit_of_quantification_ppm"
      expr: AVG(CAST(limit_of_quantification_ppm AS DOUBLE))
      comment: "Average analytical limit of quantification (ppm). Assesses whether testing methods are sufficiently sensitive relative to established MRL values."
    - name: "import_tolerance_count"
      expr: COUNT(CASE WHEN import_tolerance_flag = TRUE THEN mrl_threshold_id END)
      comment: "Number of import-specific MRL tolerances. Quantifies trade compliance complexity and export market access risk."
    - name: "revoked_tolerance_count"
      expr: COUNT(CASE WHEN tolerance_status = 'Revoked' THEN mrl_threshold_id END)
      comment: "Number of revoked MRL tolerances. Tracks regulatory withdrawals that may create compliance gaps requiring immediate product or use adjustments."
    - name: "distinct_jurisdictions_covered"
      expr: COUNT(DISTINCT jurisdiction_country_code)
      comment: "Number of distinct regulatory jurisdictions with MRL coverage. Measures global regulatory footprint for market access strategy."
    - name: "avg_processing_factor"
      expr: AVG(CAST(processing_factor AS DOUBLE))
      comment: "Average processing factor across MRL thresholds. Informs processed food residue risk modelling and label compliance for derived products."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`product_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product certification portfolio KPIs covering certification status, type distribution, renewal pipeline, and compliance flags — used by quality assurance, regulatory affairs, and commercial leadership to manage certification-driven market access."
  source: "`agriculture_ecm`.`product`.`product_certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g., Organic, GlobalG.A.P., SQF, BRC, Kosher, Halal) for portfolio segmentation."
    - name: "certification_status"
      expr: certification_status
      comment: "Current certification status (Active, Suspended, Revoked, Expired) for compliance health monitoring."
    - name: "certifying_body_name"
      expr: certifying_body_name
      comment: "Certifying body for concentration risk and body performance analysis."
    - name: "be_disclosure_required_flag"
      expr: be_disclosure_required_flag
      comment: "Flags certifications requiring bioengineered (BE) disclosure for USDA BE labelling compliance."
    - name: "non_gmo_project_verified_flag"
      expr: non_gmo_project_verified_flag
      comment: "Identifies Non-GMO Project Verified certifications for premium market positioning."
    - name: "organic_transition_flag"
      expr: organic_transition_flag
      comment: "Flags products in organic transition for pipeline and investment planning."
    - name: "effective_date_year"
      expr: YEAR(effective_date)
      comment: "Year certification became effective for cohort trend analysis."
  measures:
    - name: "total_active_certifications"
      expr: COUNT(CASE WHEN certification_status = 'Active' THEN product_certification_id END)
      comment: "Count of active product certifications. Measures the breadth of certified market access across the product portfolio."
    - name: "expiring_certifications_count"
      expr: COUNT(CASE WHEN expiration_date <= DATE_ADD(CURRENT_DATE(), 90) AND certification_status = 'Active' THEN product_certification_id END)
      comment: "Number of active certifications expiring within 90 days. Drives renewal prioritisation to prevent market access disruption."
    - name: "certification_expiry_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN expiration_date <= DATE_ADD(CURRENT_DATE(), 90) AND certification_status = 'Active' THEN product_certification_id END) / NULLIF(COUNT(CASE WHEN certification_status = 'Active' THEN product_certification_id END), 0), 2)
      comment: "Percentage of active certifications at risk of expiry within 90 days. Executive-level renewal pipeline health indicator."
    - name: "non_gmo_verified_product_count"
      expr: COUNT(CASE WHEN non_gmo_project_verified_flag = TRUE THEN product_certification_id END)
      comment: "Number of Non-GMO Project Verified certifications. Tracks premium non-GMO portfolio depth for retailer and consumer demand fulfilment."
    - name: "distinct_certification_types"
      expr: COUNT(DISTINCT certification_type)
      comment: "Number of distinct certification types held across the portfolio. Measures market access diversification and compliance programme breadth."
    - name: "be_disclosure_required_count"
      expr: COUNT(CASE WHEN be_disclosure_required_flag = TRUE THEN product_certification_id END)
      comment: "Number of certifications requiring bioengineered disclosure. Quantifies USDA BE labelling compliance scope and associated operational burden."
    - name: "organic_transition_product_count"
      expr: COUNT(CASE WHEN organic_transition_flag = TRUE THEN product_certification_id END)
      comment: "Number of products in organic transition. Tracks the organic conversion pipeline — a leading indicator of future organic revenue capacity."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`product_seed_variety`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Seed variety portfolio KPIs covering germination quality, yield potential, organic eligibility, GMO trait distribution, and variety lifecycle — used by agronomy, product development, and commercial leadership to optimise seed portfolio strategy."
  source: "`agriculture_ecm`.`product`.`seed_variety`"
  dimensions:
    - name: "crop_type"
      expr: crop_type
      comment: "Crop type (e.g., Corn, Soybean, Wheat) for portfolio segmentation and agronomic planning."
    - name: "crop_species"
      expr: crop_species
      comment: "Botanical species for scientific classification and breeding programme analysis."
    - name: "variety_status"
      expr: variety_status
      comment: "Current commercial status of the variety (Active, Discontinued, Pipeline) for portfolio health monitoring."
    - name: "seed_class"
      expr: seed_class
      comment: "Seed class (Foundation, Registered, Certified) for quality tier and supply chain analysis."
    - name: "nop_organic_eligible"
      expr: nop_organic_eligible
      comment: "Flags varieties eligible under NOP organic standards for organic production programme planning."
    - name: "trait_package"
      expr: trait_package
      comment: "Biotech trait package (e.g., RR2Y, Bt) for GMO trait portfolio and resistance management analysis."
    - name: "breeder_name"
      expr: breeder_name
      comment: "Breeding organisation for IP and licensing concentration analysis."
    - name: "catalog_year"
      expr: catalog_year
      comment: "Catalog year for vintage performance comparison and product lifecycle analysis."
    - name: "introduction_date_year"
      expr: YEAR(introduction_date)
      comment: "Year of commercial introduction for variety age and lifecycle trend analysis."
  measures:
    - name: "total_active_varieties"
      expr: COUNT(CASE WHEN variety_status = 'Active' THEN seed_variety_id END)
      comment: "Count of commercially active seed varieties. Measures portfolio breadth available to growers — a key product line health indicator."
    - name: "avg_germination_rate_pct"
      expr: AVG(CAST(germination_rate_pct AS DOUBLE))
      comment: "Average germination rate across seed varieties. Core quality KPI — low germination rates directly impact stand establishment and yield."
    - name: "avg_purity_pct"
      expr: AVG(CAST(purity_pct AS DOUBLE))
      comment: "Average seed purity percentage across varieties. Measures genetic and physical quality — directly affects crop uniformity and yield predictability."
    - name: "avg_relative_maturity_rating"
      expr: AVG(CAST(relative_maturity_rating AS DOUBLE))
      comment: "Average relative maturity rating across varieties. Informs regional portfolio fit and planting window optimisation for grower recommendations."
    - name: "avg_seeding_rate_per_acre"
      expr: AVG(CAST(seeding_rate_per_acre AS DOUBLE))
      comment: "Average recommended seeding rate per acre. Benchmarks input cost per acre for grower economics and seed volume forecasting."
    - name: "organic_eligible_variety_count"
      expr: COUNT(CASE WHEN nop_organic_eligible = TRUE THEN seed_variety_id END)
      comment: "Number of NOP organic-eligible seed varieties. Tracks organic seed supply availability — a critical constraint for organic production programmes."
    - name: "organic_eligible_variety_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN nop_organic_eligible = TRUE THEN seed_variety_id END) / NULLIF(COUNT(seed_variety_id), 0), 2)
      comment: "Percentage of seed varieties eligible for organic production. Measures organic seed portfolio depth relative to total variety count."
    - name: "distinct_trait_packages"
      expr: COUNT(DISTINCT trait_package)
      comment: "Number of distinct biotech trait packages in the portfolio. Measures trait diversity for resistance management and market segmentation strategy."
    - name: "avg_package_weight_kg"
      expr: AVG(CAST(package_weight_kg AS DOUBLE))
      comment: "Average seed package weight in kilograms. Supports logistics cost modelling and packaging standardisation decisions."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`product_grading_standard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grading standard KPIs covering quality threshold benchmarks, standard coverage, organic eligibility, and regulatory alignment — used by quality assurance, procurement, and trade compliance leadership to manage product quality standards."
  source: "`agriculture_ecm`.`product`.`grading_standard`"
  dimensions:
    - name: "commodity_type"
      expr: commodity_type
      comment: "Commodity type the grading standard applies to for cross-commodity quality analysis."
    - name: "standard_status"
      expr: standard_status
      comment: "Current status of the grading standard (Active, Superseded, Draft) for standards currency monitoring."
    - name: "administering_agency"
      expr: administering_agency
      comment: "Regulatory or industry body administering the standard for compliance jurisdiction analysis."
    - name: "organic_eligible_flag"
      expr: organic_eligible_flag
      comment: "Flags grading standards applicable to organic commodities."
    - name: "gfsi_scheme_alignment"
      expr: gfsi_scheme_alignment
      comment: "GFSI scheme alignment (e.g., SQF, BRC, FSSC 22000) for food safety certification benchmarking."
    - name: "grade_designation"
      expr: grade_designation
      comment: "Grade designation (e.g., US No. 1, US No. 2) for quality tier analysis."
    - name: "effective_date_year"
      expr: YEAR(effective_date)
      comment: "Year the grading standard became effective for standards evolution trend analysis."
  measures:
    - name: "total_active_standards"
      expr: COUNT(CASE WHEN standard_status = 'Active' THEN grading_standard_id END)
      comment: "Count of active grading standards. Measures regulatory and quality framework coverage across the commodity portfolio."
    - name: "avg_moisture_content_max_pct"
      expr: AVG(CAST(moisture_content_max_pct AS DOUBLE))
      comment: "Average maximum moisture content threshold across grading standards. Benchmarks storage quality requirements for warehouse and logistics planning."
    - name: "avg_total_defects_max_pct"
      expr: AVG(CAST(total_defects_max_pct AS DOUBLE))
      comment: "Average maximum total defects allowance across standards. Benchmarks quality tolerance levels — tighter thresholds indicate premium grade positioning."
    - name: "avg_test_weight_min_lbs_bu"
      expr: AVG(CAST(test_weight_min_lbs_bu AS DOUBLE))
      comment: "Average minimum test weight (lbs/bu) across grading standards. Benchmarks density quality floor for grain procurement and contract compliance."
    - name: "avg_foreign_material_max_pct"
      expr: AVG(CAST(foreign_material_max_pct AS DOUBLE))
      comment: "Average maximum foreign material allowance. Tracks cleanliness standards stringency — directly impacts processing efficiency and food safety risk."
    - name: "superseded_standard_count"
      expr: COUNT(CASE WHEN standard_status = 'Superseded' THEN grading_standard_id END)
      comment: "Number of superseded grading standards. Identifies outdated standards still potentially in use — a compliance currency risk indicator."
    - name: "gfsi_aligned_standard_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gfsi_scheme_alignment IS NOT NULL AND gfsi_scheme_alignment != '' THEN grading_standard_id END) / NULLIF(COUNT(grading_standard_id), 0), 2)
      comment: "Percentage of grading standards aligned to a GFSI scheme. Measures food safety certification framework coverage — a key retailer and export market access requirement."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`product_gmo_declaration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GMO declaration KPIs covering declaration status, market approval rates, threshold compliance, and verification integrity — used by regulatory affairs, trade compliance, and executive leadership to manage GMO risk and global market access."
  source: "`agriculture_ecm`.`product`.`gmo_declaration`"
  dimensions:
    - name: "declaration_status"
      expr: declaration_status
      comment: "Current status of the GMO declaration (Approved, Pending, Rejected) for compliance pipeline monitoring."
    - name: "gmo_status"
      expr: gmo_status
      comment: "GMO classification of the declared product for regulatory segmentation."
    - name: "be_disclosure_required_flag"
      expr: be_disclosure_required_flag
      comment: "Flags declarations requiring USDA bioengineered disclosure for labelling compliance."
    - name: "eu_market_approved_flag"
      expr: eu_market_approved_flag
      comment: "EU market approval status for European export eligibility analysis."
    - name: "us_market_approved_flag"
      expr: us_market_approved_flag
      comment: "US market approval status for domestic market access analysis."
    - name: "china_market_approved_flag"
      expr: china_market_approved_flag
      comment: "China market approval status for Asia-Pacific export eligibility analysis."
    - name: "organic_certified_flag"
      expr: organic_certified_flag
      comment: "Flags declarations associated with organic-certified products for dual-compliance analysis."
    - name: "declaration_date_year"
      expr: YEAR(declaration_date)
      comment: "Year of declaration for regulatory pipeline trend analysis."
  measures:
    - name: "total_approved_declarations"
      expr: COUNT(CASE WHEN declaration_status = 'Approved' THEN gmo_declaration_id END)
      comment: "Count of approved GMO declarations. Measures compliant GMO product portfolio size for market access and regulatory reporting."
    - name: "eu_market_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN eu_market_approved_flag = TRUE THEN gmo_declaration_id END) / NULLIF(COUNT(gmo_declaration_id), 0), 2)
      comment: "Percentage of GMO declarations approved for EU market access. Critical KPI for European export revenue risk management."
    - name: "china_market_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN china_market_approved_flag = TRUE THEN gmo_declaration_id END) / NULLIF(COUNT(gmo_declaration_id), 0), 2)
      comment: "Percentage of GMO declarations approved for China market access. Tracks one of the most strategically important and complex GMO approval markets."
    - name: "avg_gmo_threshold_percent"
      expr: AVG(CAST(gmo_threshold_percent AS DOUBLE))
      comment: "Average GMO threshold percentage across declarations. Benchmarks allowable GMO content levels for labelling and market compliance."
    - name: "avg_test_result_percent"
      expr: AVG(CAST(test_result_percent AS DOUBLE))
      comment: "Average actual GMO test result percentage. Compared against thresholds to assess compliance headroom and labelling risk."
    - name: "be_disclosure_required_count"
      expr: COUNT(CASE WHEN be_disclosure_required_flag = TRUE THEN gmo_declaration_id END)
      comment: "Number of declarations requiring bioengineered disclosure. Quantifies USDA BE labelling compliance scope across the product portfolio."
    - name: "multi_market_approved_count"
      expr: COUNT(CASE WHEN us_market_approved_flag = TRUE AND eu_market_approved_flag = TRUE AND china_market_approved_flag = TRUE THEN gmo_declaration_id END)
      comment: "Number of declarations approved across all three major markets (US, EU, China). Identifies the highest-value, lowest-risk GMO products for global distribution."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`product_crop_use_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crop use registration KPIs covering registration coverage, expiry pipeline, application rate benchmarks, and jurisdictional reach — used by regulatory affairs and agronomy leadership to manage agrochemical use authorisation and compliance."
  source: "`agriculture_ecm`.`product`.`crop_use_registration`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current registration status (Active, Expired, Pending, Revoked) for compliance pipeline monitoring."
    - name: "jurisdiction_country_code"
      expr: jurisdiction_country_code
      comment: "Regulatory jurisdiction for market-specific registration coverage analysis."
    - name: "expiry_date_year"
      expr: YEAR(expiry_date)
      comment: "Year of registration expiry for renewal pipeline planning."
    - name: "approved_use_date_year"
      expr: YEAR(approved_use_date)
      comment: "Year of use approval for registration vintage and trend analysis."
  measures:
    - name: "total_active_registrations"
      expr: COUNT(CASE WHEN registration_status = 'Active' THEN crop_use_registration_id END)
      comment: "Count of active crop use registrations. Measures the breadth of legally authorised agrochemical-crop combinations — gaps create compliance and liability risk."
    - name: "expiring_registrations_90d"
      expr: COUNT(CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 90) AND registration_status = 'Active' THEN crop_use_registration_id END)
      comment: "Active registrations expiring within 90 days. Drives renewal prioritisation to prevent use authorisation lapses and field compliance failures."
    - name: "registration_expiry_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 90) AND registration_status = 'Active' THEN crop_use_registration_id END) / NULLIF(COUNT(CASE WHEN registration_status = 'Active' THEN crop_use_registration_id END), 0), 2)
      comment: "Percentage of active registrations at near-term expiry risk. Executive-level regulatory pipeline health indicator."
    - name: "avg_max_application_rate"
      expr: AVG(CAST(max_application_rate AS DOUBLE))
      comment: "Average maximum application rate across crop use registrations. Benchmarks authorised use intensity for environmental load and resistance management."
    - name: "distinct_jurisdictions_covered"
      expr: COUNT(DISTINCT jurisdiction_country_code)
      comment: "Number of distinct jurisdictions with active crop use registrations. Measures global regulatory footprint for market access and export strategy."
$$;