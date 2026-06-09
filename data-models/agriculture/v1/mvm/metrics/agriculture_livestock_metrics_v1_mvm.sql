-- Metric views for domain: livestock | Business: Agriculture | Version: 1 | Generated on: 2026-05-01 18:41:06

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`livestock_animal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core livestock animal inventory and acquisition metrics. Tracks herd composition, acquisition economics, weight performance, and lifecycle stage distribution to support stocking decisions, procurement budgeting, and animal welfare oversight."
  source: "`agriculture_ecm`.`livestock`.`animal`"
  dimensions:
    - name: "species_code"
      expr: species_code
      comment: "Species classification (e.g. bovine, porcine, ovine) for cross-species performance comparison."
    - name: "sex_code"
      expr: sex_code
      comment: "Animal sex (M/F/castrate) used to segment production class performance and pricing."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Current lifecycle stage (e.g. calf, grower, finisher, breeder) for stage-specific KPI benchmarking."
    - name: "production_class"
      expr: production_class
      comment: "Production classification (e.g. beef, dairy, breeding stock) to align metrics with business segment."
    - name: "disposition_status"
      expr: disposition_status
      comment: "Current disposition status of the animal (active, sold, deceased, culled) for inventory reconciliation."
    - name: "health_status"
      expr: health_status
      comment: "Current health status to monitor morbidity distribution across the herd."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for COOL compliance reporting and sourcing analysis."
    - name: "antibiotic_free"
      expr: antibiotic_free
      comment: "Flag indicating antibiotic-free status, critical for premium market eligibility."
    - name: "gmo_status"
      expr: gmo_status
      comment: "GMO status of the animal for non-GMO program compliance and market segmentation."
    - name: "acquisition_date_month"
      expr: DATE_TRUNC('MONTH', acquisition_date)
      comment: "Month of acquisition for trend analysis of procurement volumes and costs."
    - name: "origin_type"
      expr: origin_type
      comment: "Origin type (e.g. purchased, born-on-farm, transferred) to evaluate sourcing channel economics."
  measures:
    - name: "total_animals"
      expr: COUNT(1)
      comment: "Total number of animal records. Baseline inventory count used to assess herd size and stocking levels."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total capital invested in animal acquisitions. Directly informs procurement budget utilization and cost-of-goods-sold for livestock."
    - name: "avg_acquisition_cost_per_head"
      expr: AVG(CAST(acquisition_cost AS DOUBLE))
      comment: "Average acquisition cost per animal head. Benchmarks procurement efficiency and tracks price trends by species, origin, or breed."
    - name: "avg_current_weight_kg"
      expr: AVG(CAST(current_weight_kg AS DOUBLE))
      comment: "Average live weight of animals currently on inventory. Indicates production readiness and market timing for harvest or sale."
    - name: "avg_birth_weight_kg"
      expr: AVG(CAST(birth_weight_kg AS DOUBLE))
      comment: "Average birth weight across animals. Early indicator of genetic performance and colostrum/nutrition program effectiveness."
    - name: "avg_breed_composition_pct"
      expr: AVG(CAST(breed_composition_pct AS DOUBLE))
      comment: "Average breed composition percentage. Supports genetic program evaluation and premium breed certification compliance."
    - name: "antibiotic_free_animal_count"
      expr: COUNT(CASE WHEN antibiotic_free = TRUE THEN 1 END)
      comment: "Count of animals qualifying as antibiotic-free. Measures premium program inventory availability and market eligibility."
    - name: "antibiotic_free_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN antibiotic_free = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of herd that is antibiotic-free. Key KPI for natural/organic program compliance and premium revenue potential."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`livestock_animal_disposition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks the financial and quality outcomes of animal dispositions including harvest, death, condemnation, and salvage. Supports carcass yield optimization, regulatory compliance, and mortality cost analysis."
  source: "`agriculture_ecm`.`livestock`.`animal_disposition`"
  dimensions:
    - name: "disposition_type"
      expr: disposition_type
      comment: "Type of disposition (harvest, death, cull, condemnation, salvage) for outcome segmentation."
    - name: "disposition_status"
      expr: disposition_status
      comment: "Current processing status of the disposition record for pipeline monitoring."
    - name: "species_code"
      expr: species_code
      comment: "Species code for cross-species disposition performance comparison."
    - name: "sex_code"
      expr: sex_code
      comment: "Animal sex to analyze yield and quality grade differences by gender."
    - name: "usda_quality_grade"
      expr: usda_quality_grade
      comment: "USDA quality grade (Prime, Choice, Select, etc.) for premium yield analysis and pricing strategy."
    - name: "cause_of_death_code"
      expr: cause_of_death_code
      comment: "Cause of death code for mortality root-cause analysis and health program evaluation."
    - name: "condemnation_reason_code"
      expr: condemnation_reason_code
      comment: "Reason for carcass condemnation to identify quality or health failure patterns."
    - name: "disposition_date_month"
      expr: DATE_TRUNC('MONTH', disposition_date)
      comment: "Month of disposition for throughput trend analysis and seasonal harvest planning."
    - name: "antibiotic_withdrawal_compliant"
      expr: antibiotic_withdrawal_compliant
      comment: "Indicates whether the animal met antibiotic withdrawal requirements at time of disposition — critical for food safety compliance."
    - name: "regulatory_reported"
      expr: regulatory_reported
      comment: "Flag indicating whether the disposition was reported to regulatory authorities as required."
    - name: "carcass_disposition_code"
      expr: carcass_disposition_code
      comment: "Carcass disposition outcome code (passed, condemned, retained) for yield and loss analysis."
  measures:
    - name: "total_dispositions"
      expr: COUNT(1)
      comment: "Total number of animal disposition events. Baseline throughput measure for harvest and mortality operations."
    - name: "avg_dressing_yield_pct"
      expr: AVG(CAST(dressing_yield_pct AS DOUBLE))
      comment: "Average dressing yield percentage (hot carcass weight / live weight). Core profitability KPI for beef and pork operations — directly impacts revenue per head."
    - name: "avg_hot_carcass_weight_kg"
      expr: AVG(CAST(hot_carcass_weight_kg AS DOUBLE))
      comment: "Average hot carcass weight in kg. Determines revenue per head at harvest and benchmarks genetic and nutrition program effectiveness."
    - name: "total_hot_carcass_weight_kg"
      expr: SUM(CAST(hot_carcass_weight_kg AS DOUBLE))
      comment: "Total hot carcass weight produced across all dispositions. Measures total production output for capacity planning and sales fulfillment."
    - name: "avg_live_weight_kg"
      expr: AVG(CAST(live_weight_kg AS DOUBLE))
      comment: "Average live weight at disposition. Benchmarks market readiness and feed program performance against target market weights."
    - name: "avg_usda_yield_grade"
      expr: AVG(CAST(usda_yield_grade AS DOUBLE))
      comment: "Average USDA yield grade score. Lower scores indicate higher cutability and premium value — key metric for genetic selection and feeding programs."
    - name: "total_salvage_sale_value"
      expr: SUM(CAST(salvage_sale_value AS DOUBLE))
      comment: "Total revenue recovered from salvage dispositions (cull animals, condemned carcasses). Measures loss recovery effectiveness."
    - name: "withdrawal_non_compliant_count"
      expr: COUNT(CASE WHEN antibiotic_withdrawal_compliant = FALSE THEN 1 END)
      comment: "Count of dispositions where antibiotic withdrawal compliance was not met. Critical food safety and regulatory risk KPI — any non-zero value triggers immediate investigation."
    - name: "mortality_count"
      expr: COUNT(CASE WHEN disposition_type = 'DEATH' THEN 1 END)
      comment: "Count of animal deaths. Tracks mortality events to evaluate herd health program effectiveness and financial loss from non-productive deaths."
    - name: "regulatory_unreported_count"
      expr: COUNT(CASE WHEN regulatory_reported = FALSE THEN 1 END)
      comment: "Count of dispositions requiring regulatory reporting that have not yet been reported. Compliance gap metric — non-zero values represent regulatory exposure."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`livestock_animal_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and volumetric metrics for livestock buy/sell transactions. Supports procurement cost analysis, sales revenue tracking, price benchmarking, and transaction channel performance evaluation."
  source: "`agriculture_ecm`.`livestock`.`animal_transaction`"
  dimensions:
    - name: "transaction_direction"
      expr: transaction_direction
      comment: "Direction of transaction (purchase/sale) to separate procurement spend from sales revenue."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the transaction (pending, settled, cancelled) for pipeline and settlement monitoring."
    - name: "transaction_channel"
      expr: transaction_channel
      comment: "Channel through which the transaction occurred (auction, direct, contract, online) for channel economics analysis."
    - name: "species"
      expr: species
      comment: "Species involved in the transaction for cross-species financial benchmarking."
    - name: "breed"
      expr: breed
      comment: "Breed of animals transacted to analyze breed-level price premiums and procurement patterns."
    - name: "origin_country"
      expr: origin_country
      comment: "Country of origin for import/export analysis and COOL compliance tracking."
    - name: "origin_state"
      expr: origin_state
      comment: "State of origin for regional sourcing analysis and disease traceability."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency financial consolidation."
    - name: "transaction_date_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of transaction for trend analysis of procurement and sales volumes."
    - name: "quarantine_required"
      expr: quarantine_required
      comment: "Flag indicating whether purchased animals require quarantine — impacts receiving logistics and biosecurity cost."
    - name: "grade_yield_basis"
      expr: grade_yield_basis
      comment: "Pricing basis (live weight, dressed weight, grade/yield) used in the transaction for price comparison normalization."
  measures:
    - name: "total_transaction_value"
      expr: SUM(CAST(total_transaction_value AS DOUBLE))
      comment: "Total dollar value of all livestock transactions. Primary financial KPI for livestock trading — drives revenue and procurement cost reporting."
    - name: "avg_price_per_head"
      expr: AVG(CAST(price_per_head AS DOUBLE))
      comment: "Average price paid or received per head. Benchmarks market pricing trends and negotiation effectiveness by species, breed, and channel."
    - name: "avg_price_per_cwt"
      expr: AVG(CAST(price_per_cwt AS DOUBLE))
      comment: "Average price per hundredweight (cwt). Industry-standard pricing metric for cattle and hog markets — used for contract benchmarking and market analysis."
    - name: "total_weight_lbs"
      expr: SUM(CAST(total_weight_lbs AS DOUBLE))
      comment: "Total weight of animals transacted in pounds. Measures physical volume of livestock traded for capacity and logistics planning."
    - name: "avg_weight_per_head_lbs"
      expr: AVG(CAST(avg_weight_per_head_lbs AS DOUBLE))
      comment: "Average weight per head at transaction. Indicates animal quality and production stage at point of sale or purchase."
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total number of livestock transactions. Baseline volume metric for trading activity and market participation."
    - name: "quarantine_required_count"
      expr: COUNT(CASE WHEN quarantine_required = TRUE THEN 1 END)
      comment: "Count of transactions requiring quarantine. Drives biosecurity resource planning and receiving facility capacity management."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`livestock_health_treatment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks animal health treatment events, costs, outcomes, and antibiotic usage. Supports morbidity management, treatment cost control, withdrawal compliance, and antibiotic stewardship programs."
  source: "`agriculture_ecm`.`livestock`.`health_treatment`"
  dimensions:
    - name: "treatment_type"
      expr: treatment_type
      comment: "Type of treatment administered (antibiotic, anti-inflammatory, supportive care, etc.) for protocol effectiveness analysis."
    - name: "treatment_status"
      expr: treatment_status
      comment: "Current status of the treatment record (active, completed, failed) for case management."
    - name: "treatment_outcome"
      expr: treatment_outcome
      comment: "Outcome of the treatment (recovered, retreated, died, culled) to evaluate protocol efficacy."
    - name: "diagnosis_code"
      expr: diagnosis_code
      comment: "Diagnosis code associated with the treatment for disease incidence tracking and protocol matching."
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route of drug administration (IM, SQ, oral, IV) for protocol compliance and labor cost analysis."
    - name: "withdrawal_status"
      expr: withdrawal_status
      comment: "Current withdrawal period status (active, cleared, expired) — critical for harvest eligibility and food safety."
    - name: "retreatment_flag"
      expr: retreatment_flag
      comment: "Indicates whether this is a retreatment event. High retreatment rates signal protocol failure or antimicrobial resistance concerns."
    - name: "treatment_date_month"
      expr: DATE_TRUNC('MONTH', treatment_date)
      comment: "Month of treatment for seasonal morbidity trend analysis and resource planning."
    - name: "record_type"
      expr: record_type
      comment: "Record type classification for distinguishing individual vs. group treatment events."
  measures:
    - name: "total_treatment_events"
      expr: COUNT(1)
      comment: "Total number of health treatment events. Baseline morbidity volume metric used to assess herd health burden and veterinary resource utilization."
    - name: "total_treatment_cost"
      expr: SUM(CAST(treatment_cost AS DOUBLE))
      comment: "Total cost of all health treatments. Direct input to cost-of-production and health program ROI analysis — high treatment costs signal herd health or biosecurity failures."
    - name: "avg_treatment_cost_per_event"
      expr: AVG(CAST(treatment_cost AS DOUBLE))
      comment: "Average cost per treatment event. Benchmarks protocol cost efficiency and identifies high-cost disease categories for intervention."
    - name: "total_product_used"
      expr: SUM(CAST(total_product_used AS DOUBLE))
      comment: "Total volume of veterinary product used across all treatments. Supports antibiotic stewardship reporting and inventory management."
    - name: "avg_dosage_amount"
      expr: AVG(CAST(dosage_amount AS DOUBLE))
      comment: "Average dosage amount administered per treatment event. Validates protocol compliance and identifies dosing anomalies."
    - name: "retreatment_count"
      expr: COUNT(CASE WHEN retreatment_flag = TRUE THEN 1 END)
      comment: "Count of retreatment events. High retreatment rates indicate protocol failure, antimicrobial resistance, or misdiagnosis — a key animal health KPI."
    - name: "retreatment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN retreatment_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of treatments that are retreatments. Industry benchmark KPI for antibiotic stewardship and protocol effectiveness — targets typically below 10-15%."
    - name: "active_withdrawal_count"
      expr: COUNT(CASE WHEN withdrawal_status = 'ACTIVE' THEN 1 END)
      comment: "Count of animals currently under active withdrawal periods. Directly impacts harvest scheduling and market-ready inventory availability."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`livestock_herd`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Herd-level performance, health, and certification metrics. Provides executive visibility into herd composition, productivity, welfare compliance, and organic/specialty program participation across the enterprise."
  source: "`agriculture_ecm`.`livestock`.`herd`"
  dimensions:
    - name: "species"
      expr: species
      comment: "Species of the herd for cross-species portfolio analysis."
    - name: "production_type"
      expr: production_type
      comment: "Production type (beef, dairy, swine, poultry, etc.) for segment-level performance benchmarking."
    - name: "herd_status"
      expr: herd_status
      comment: "Current operational status of the herd (active, dispersed, quarantined) for inventory management."
    - name: "classification"
      expr: classification
      comment: "Herd classification (commercial, seedstock, show, etc.) for program-specific KPI segmentation."
    - name: "biosecurity_level"
      expr: biosecurity_level
      comment: "Biosecurity level assigned to the herd for risk-stratified health management."
    - name: "housing_type"
      expr: housing_type
      comment: "Housing type (pasture, confinement, semi-confinement) for welfare and production efficiency analysis."
    - name: "is_organic_certified"
      expr: is_organic_certified
      comment: "Organic certification status — determines premium market eligibility and program compliance requirements."
    - name: "is_antibiotic_free"
      expr: is_antibiotic_free
      comment: "Antibiotic-free program status for natural/clean label market segmentation."
    - name: "is_gmo_free"
      expr: is_gmo_free
      comment: "GMO-free status for non-GMO program compliance and premium pricing eligibility."
    - name: "disease_status"
      expr: disease_status
      comment: "Current disease status of the herd (clean, suspect, positive, quarantined) for biosecurity risk management."
    - name: "movement_restriction_flag"
      expr: movement_restriction_flag
      comment: "Indicates whether the herd is under movement restriction — impacts logistics, sales, and regulatory compliance."
  measures:
    - name: "total_herds"
      expr: COUNT(1)
      comment: "Total number of active herd units. Baseline measure for enterprise livestock portfolio size."
    - name: "avg_morbidity_rate_pct"
      expr: AVG(CAST(morbidity_rate_pct AS DOUBLE))
      comment: "Average morbidity rate across herds. Key herd health KPI — elevated rates trigger health protocol reviews and biosecurity interventions."
    - name: "avg_mortality_rate_pct"
      expr: AVG(CAST(mortality_rate_pct AS DOUBLE))
      comment: "Average mortality rate across herds. Critical financial and welfare KPI — directly impacts cost of production and animal welfare audit outcomes."
    - name: "avg_daily_gain_kg"
      expr: AVG(CAST(avg_daily_gain_kg AS DOUBLE))
      comment: "Average daily gain in kg across herds. Primary production efficiency KPI for beef and grow-finish operations — drives days-to-market and feed cost per pound of gain."
    - name: "avg_body_weight_kg"
      expr: AVG(CAST(avg_body_weight_kg AS DOUBLE))
      comment: "Average body weight across herds. Indicates overall production stage and market readiness of the livestock portfolio."
    - name: "avg_stocking_density_head_per_ha"
      expr: AVG(CAST(stocking_density_head_per_ha AS DOUBLE))
      comment: "Average stocking density in head per hectare. Welfare and environmental compliance KPI — excessive density triggers regulatory and certification risk."
    - name: "avg_welfare_audit_score"
      expr: AVG(CAST(welfare_audit_score AS DOUBLE))
      comment: "Average animal welfare audit score across herds. Directly impacts retailer and processor certification eligibility and brand reputation."
    - name: "total_pasture_area_ha"
      expr: SUM(CAST(pasture_area_ha AS DOUBLE))
      comment: "Total pasture area in hectares under livestock production. Supports land utilization analysis and stocking rate optimization."
    - name: "organic_certified_herd_count"
      expr: COUNT(CASE WHEN is_organic_certified = TRUE THEN 1 END)
      comment: "Count of organically certified herds. Measures premium program capacity and organic revenue potential."
    - name: "movement_restricted_herd_count"
      expr: COUNT(CASE WHEN movement_restriction_flag = TRUE THEN 1 END)
      comment: "Count of herds under movement restriction. Operational risk KPI — restricted herds cannot be sold or transferred, directly impacting cash flow and market commitments."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`livestock_feed_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Feed delivery execution metrics covering cost, quantity accuracy, and ration compliance. Supports feed cost management, delivery variance control, and medicated feed regulatory compliance."
  source: "`agriculture_ecm`.`livestock`.`feed_delivery`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Status of the feed delivery (completed, partial, missed, rejected) for operational performance monitoring."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method of feed delivery (TMR, commodity, supplement, etc.) for cost and efficiency benchmarking."
    - name: "feed_source_type"
      expr: feed_source_type
      comment: "Source type of feed (on-farm, purchased, custom mixed) for supply chain cost analysis."
    - name: "ration_name"
      expr: ration_name
      comment: "Name of the ration delivered for ration-level cost and compliance tracking."
    - name: "is_medicated_feed"
      expr: is_medicated_feed
      comment: "Indicates medicated feed delivery — requires VFD compliance and withdrawal period tracking."
    - name: "organic_certified"
      expr: organic_certified
      comment: "Organic certification status of the feed delivered — required for organic herd program compliance."
    - name: "gmo_status"
      expr: gmo_status
      comment: "GMO status of the feed for non-GMO program compliance verification."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of feed cost transactions for multi-currency financial consolidation."
    - name: "delivery_timestamp_date"
      expr: DATE_TRUNC('DAY', delivery_timestamp)
      comment: "Date of feed delivery for daily feed cost and consumption trend analysis."
  measures:
    - name: "total_feed_cost"
      expr: SUM(CAST(total_feed_cost AS DOUBLE))
      comment: "Total feed cost across all deliveries. Feed is typically the largest single cost in livestock production — this KPI drives cost-of-production and margin analysis."
    - name: "avg_feed_cost_per_kg"
      expr: AVG(CAST(feed_cost_per_kg AS DOUBLE))
      comment: "Average feed cost per kilogram delivered. Benchmarks feed procurement efficiency and tracks commodity price impact on production costs."
    - name: "total_quantity_delivered_asfed_kg"
      expr: SUM(CAST(quantity_delivered_asfed_kg AS DOUBLE))
      comment: "Total as-fed feed quantity delivered in kg. Measures total feed volume consumed for inventory reconciliation and nutritional program monitoring."
    - name: "total_quantity_delivered_dm_kg"
      expr: SUM(CAST(quantity_delivered_dm_kg AS DOUBLE))
      comment: "Total dry matter feed quantity delivered in kg. Dry matter basis is the nutritionally accurate measure for ration formulation compliance and intake monitoring."
    - name: "total_refusal_quantity_kg"
      expr: SUM(CAST(refusal_quantity_kg AS DOUBLE))
      comment: "Total feed refusal quantity in kg. High refusals indicate palatability issues, over-delivery, or health problems — directly impacts feed cost efficiency."
    - name: "avg_delivery_variance_kg"
      expr: AVG(CAST(delivery_variance_kg AS DOUBLE))
      comment: "Average variance between prescribed and delivered feed quantity. Measures delivery accuracy — persistent variance indicates equipment calibration or operator compliance issues."
    - name: "avg_dry_matter_pct"
      expr: AVG(CAST(dry_matter_pct AS DOUBLE))
      comment: "Average dry matter percentage of delivered feed. Monitors feed quality consistency — low DM% increases as-fed cost per unit of nutrition."
    - name: "medicated_feed_delivery_count"
      expr: COUNT(CASE WHEN is_medicated_feed = TRUE THEN 1 END)
      comment: "Count of medicated feed deliveries. Supports VFD compliance auditing and antibiotic stewardship program reporting."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`livestock_milk_production_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dairy production performance metrics covering milk yield, component quality, and somatic cell count. Supports milk revenue optimization, udder health management, and dairy program compliance."
  source: "`agriculture_ecm`.`livestock`.`milk_production_record`"
  dimensions:
    - name: "milking_session"
      expr: milking_session
      comment: "Milking session (AM/PM/3x) for session-level yield and quality analysis."
    - name: "record_status"
      expr: record_status
      comment: "Status of the milk production record (valid, diverted, discarded) for data quality filtering."
    - name: "record_type"
      expr: record_type
      comment: "Record type (individual cow, group, bulk tank) for appropriate aggregation level selection."
    - name: "is_abnormal_milk"
      expr: is_abnormal_milk
      comment: "Flag for abnormal milk (mastitis, colostrum, antibiotic residue) — abnormal milk is diverted and not sold, impacting revenue."
    - name: "divert_reason"
      expr: divert_reason
      comment: "Reason milk was diverted from the bulk tank (antibiotic residue, mastitis, colostrum) for loss analysis."
    - name: "dhia_test_day_flag"
      expr: dhia_test_day_flag
      comment: "Indicates official DHIA test day records for genetic evaluation and herd improvement program compliance."
    - name: "milking_date_month"
      expr: DATE_TRUNC('MONTH', milking_date)
      comment: "Month of milking for seasonal production trend analysis and lactation curve benchmarking."
    - name: "data_source_system"
      expr: data_source_system
      comment: "Source system of the milking record (parlor controller, hand entry, DHIA) for data quality stratification."
  measures:
    - name: "total_milk_yield_kg"
      expr: SUM(CAST(milk_yield_kg AS DOUBLE))
      comment: "Total milk yield in kg. Primary dairy revenue driver — directly determines milk check value and production quota compliance."
    - name: "avg_milk_yield_kg_per_milking"
      expr: AVG(CAST(milk_yield_kg AS DOUBLE))
      comment: "Average milk yield per milking event. Benchmarks individual and herd productivity against breed and lactation stage expectations."
    - name: "avg_fat_pct"
      expr: AVG(CAST(fat_pct AS DOUBLE))
      comment: "Average milk fat percentage. Component pricing KPI — fat content directly determines milk price premium in most dairy markets."
    - name: "avg_protein_pct"
      expr: AVG(CAST(protein_pct AS DOUBLE))
      comment: "Average milk protein percentage. Second most important component pricing factor — protein premiums are significant in cheese and specialty dairy markets."
    - name: "total_fat_yield_kg"
      expr: SUM(CAST(fat_yield_kg AS DOUBLE))
      comment: "Total fat yield in kg. Absolute component production metric for milk revenue calculation and quota management."
    - name: "total_protein_yield_kg"
      expr: SUM(CAST(protein_yield_kg AS DOUBLE))
      comment: "Total protein yield in kg. Absolute component production metric for milk revenue calculation and cheese yield estimation."
    - name: "avg_somatic_cell_count"
      expr: AVG(CAST(somatic_cell_count AS DOUBLE))
      comment: "Average somatic cell count (SCC). Primary udder health and milk quality KPI — high SCC triggers price penalties, processor rejection, and indicates mastitis prevalence."
    - name: "abnormal_milk_event_count"
      expr: COUNT(CASE WHEN is_abnormal_milk = TRUE THEN 1 END)
      comment: "Count of abnormal milk events (diverted milk). Measures milk loss volume and frequency — high counts indicate udder health or withdrawal compliance issues."
    - name: "avg_lactose_pct"
      expr: AVG(CAST(lactose_pct AS DOUBLE))
      comment: "Average lactose percentage. Declining lactose is an early indicator of subclinical mastitis — used in udder health monitoring programs."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`livestock_weight_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Livestock weight performance and growth metrics. Tracks average daily gain, body condition, and harvest readiness to optimize feed conversion, market timing, and production efficiency."
  source: "`agriculture_ecm`.`livestock`.`weight_measurement`"
  dimensions:
    - name: "species_code"
      expr: species_code
      comment: "Species code for cross-species growth performance benchmarking."
    - name: "sex_code"
      expr: sex_code
      comment: "Animal sex for gender-specific growth rate and market weight analysis."
    - name: "production_stage"
      expr: production_stage
      comment: "Production stage (starter, grower, finisher, etc.) for stage-specific ADG and feed efficiency benchmarking."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used for weight measurement (scale, visual estimate, weigh tape) for data quality stratification."
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the weight measurement record (valid, flagged, voided) for data quality filtering."
    - name: "harvest_ready_flag"
      expr: harvest_ready_flag
      comment: "Indicates animals meeting target weight and condition for harvest. Directly drives harvest scheduling and sales order fulfillment."
    - name: "weight_variance_flag"
      expr: weight_variance_flag
      comment: "Flag for weight measurements outside expected variance range — identifies outliers requiring investigation."
    - name: "breed_code"
      expr: breed_code
      comment: "Breed code for breed-level growth performance comparison and genetic program evaluation."
    - name: "measurement_date_month"
      expr: DATE_TRUNC('MONTH', measurement_date)
      comment: "Month of weight measurement for growth trend analysis and seasonal performance patterns."
    - name: "weigh_condition"
      expr: weigh_condition
      comment: "Condition at weighing (full, shrunk, pencil shrink applied) for weight comparison normalization."
  measures:
    - name: "avg_adg_kg"
      expr: AVG(CAST(adg_kg AS DOUBLE))
      comment: "Average daily gain in kg. The single most important growth efficiency KPI in beef and swine production — directly determines days-to-market and feed cost per unit of gain."
    - name: "avg_body_weight_kg"
      expr: AVG(CAST(body_weight_kg AS DOUBLE))
      comment: "Average body weight in kg at time of measurement. Tracks progress toward market weight targets and informs harvest scheduling."
    - name: "avg_adjusted_weight_kg"
      expr: AVG(CAST(adjusted_weight_kg AS DOUBLE))
      comment: "Average adjusted weight in kg (standardized for shrink and condition). Provides comparable weight data across different weighing conditions for accurate performance benchmarking."
    - name: "avg_body_condition_score"
      expr: AVG(CAST(body_condition_score AS DOUBLE))
      comment: "Average body condition score. Nutritional status KPI — scores outside optimal range indicate over- or under-conditioning, impacting reproductive performance and feed efficiency."
    - name: "harvest_ready_count"
      expr: COUNT(CASE WHEN harvest_ready_flag = TRUE THEN 1 END)
      comment: "Count of animals flagged as harvest-ready. Directly drives harvest scheduling, sales order fulfillment, and cash flow forecasting."
    - name: "avg_shrink_pct"
      expr: AVG(CAST(shrink_pct AS DOUBLE))
      comment: "Average shrink percentage applied to weight measurements. High shrink indicates transport or handling stress — impacts net weight sold and animal welfare."
    - name: "total_group_weight_kg"
      expr: SUM(CAST(total_group_weight_kg AS DOUBLE))
      comment: "Total group weight in kg across all weight measurement events. Supports pen-level inventory valuation and feed budget calculations."
    - name: "avg_hip_height_cm"
      expr: AVG(CAST(hip_height_cm AS DOUBLE))
      comment: "Average hip height in cm. Frame score input metric used in genetic selection programs and market weight target calibration."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`livestock_breeding_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reproductive performance and genetic investment metrics. Tracks conception rates, EPD values, and breeding program costs to optimize genetic progress and reproductive efficiency."
  source: "`agriculture_ecm`.`livestock`.`breeding_event`"
  dimensions:
    - name: "breeding_method"
      expr: breeding_method
      comment: "Breeding method used (AI, natural service, ET, IVF) for method-level conception rate and cost comparison."
    - name: "event_status"
      expr: event_status
      comment: "Status of the breeding event (pending, confirmed, open, failed) for reproductive pipeline management."
    - name: "conception_result"
      expr: conception_result
      comment: "Outcome of conception check (pregnant, open, repeat breeder) for reproductive efficiency analysis."
    - name: "sire_breed"
      expr: sire_breed
      comment: "Breed of the sire used for sire-level genetic performance and conception rate analysis."
    - name: "synchronization_protocol"
      expr: synchronization_protocol
      comment: "Synchronization protocol used (CIDR, OvSynch, etc.) for protocol-level conception rate benchmarking."
    - name: "genomic_enhanced_epd"
      expr: genomic_enhanced_epd
      comment: "Indicates whether genomic-enhanced EPDs were used — higher genetic accuracy supports premium semen pricing justification."
    - name: "record_type"
      expr: record_type
      comment: "Record type (AI service, natural service, embryo transfer) for appropriate aggregation and cost allocation."
    - name: "breeding_date_month"
      expr: DATE_TRUNC('MONTH', breeding_date)
      comment: "Month of breeding event for seasonal reproductive performance trend analysis."
  measures:
    - name: "total_breeding_events"
      expr: COUNT(1)
      comment: "Total number of breeding events. Baseline reproductive activity metric for herd expansion and replacement heifer program planning."
    - name: "avg_conception_rate_history_pct"
      expr: AVG(CAST(conception_rate_history_pct AS DOUBLE))
      comment: "Average historical conception rate percentage. Core reproductive efficiency KPI — low conception rates directly increase cost per pregnancy and extend calving intervals."
    - name: "total_breeding_cost"
      expr: SUM(CAST(cost_per_unit AS DOUBLE))
      comment: "Total breeding input cost (semen, synchronization supplies, labor). Measures genetic investment and reproductive program cost for ROI analysis."
    - name: "avg_epd_weaning_weight"
      expr: AVG(CAST(epd_weaning_weight AS DOUBLE))
      comment: "Average EPD for weaning weight across breeding events. Measures genetic progress toward heavier weaning weights — directly impacts calf sale value."
    - name: "avg_epd_marbling"
      expr: AVG(CAST(epd_marbling AS DOUBLE))
      comment: "Average EPD for marbling across breeding events. Measures genetic selection pressure toward USDA Choice/Prime grades — impacts carcass premium revenue."
    - name: "avg_post_thaw_motility_pct"
      expr: AVG(CAST(post_thaw_motility_pct AS DOUBLE))
      comment: "Average post-thaw semen motility percentage. Quality control KPI for AI programs — low motility reduces conception rates and wastes expensive semen inventory."
    - name: "avg_epd_calving_ease"
      expr: AVG(CAST(epd_calving_ease AS DOUBLE))
      comment: "Average EPD for calving ease. Welfare and labor cost KPI — difficult calvings increase veterinary costs, calf mortality, and labor requirements."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`livestock_vaccination_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vaccination program compliance, coverage, and cost metrics. Supports herd immunity management, regulatory compliance, and biosecurity program effectiveness evaluation."
  source: "`agriculture_ecm`.`livestock`.`vaccination_record`"
  dimensions:
    - name: "vaccine_type"
      expr: vaccine_type
      comment: "Type of vaccine administered (modified live, killed, toxoid, etc.) for protocol compliance and efficacy analysis."
    - name: "disease_target"
      expr: disease_target
      comment: "Disease targeted by the vaccination for disease-specific coverage and immunity gap analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the vaccination record (compliant, overdue, exempt) for program adherence monitoring."
    - name: "administration_route"
      expr: administration_route
      comment: "Route of vaccine administration (IM, SQ, intranasal, oral) for protocol compliance verification."
    - name: "species"
      expr: species
      comment: "Species vaccinated for cross-species program coverage analysis."
    - name: "adverse_reaction_observed"
      expr: adverse_reaction_observed
      comment: "Flag for observed adverse reactions — high rates trigger product safety reviews and protocol changes."
    - name: "cold_chain_maintained"
      expr: cold_chain_maintained
      comment: "Indicates whether cold chain was maintained during vaccine handling — cold chain failures compromise vaccine efficacy."
    - name: "administration_date_month"
      expr: DATE_TRUNC('MONTH', administration_date)
      comment: "Month of vaccine administration for seasonal program scheduling and coverage trend analysis."
  measures:
    - name: "total_vaccination_events"
      expr: COUNT(1)
      comment: "Total number of vaccination events. Baseline measure for vaccination program activity and herd immunity coverage tracking."
    - name: "total_dosage_ml"
      expr: SUM(CAST(dosage_ml AS DOUBLE))
      comment: "Total vaccine volume administered in ml. Supports vaccine inventory management and procurement planning."
    - name: "avg_dosage_ml"
      expr: AVG(CAST(dosage_ml AS DOUBLE))
      comment: "Average dosage per vaccination event. Validates protocol compliance — deviations from label dosage indicate training or compliance issues."
    - name: "adverse_reaction_count"
      expr: COUNT(CASE WHEN adverse_reaction_observed = TRUE THEN 1 END)
      comment: "Count of vaccination events with observed adverse reactions. Safety KPI — high adverse reaction rates trigger product review and protocol modification."
    - name: "adverse_reaction_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN adverse_reaction_observed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vaccinations resulting in adverse reactions. Vaccine safety KPI used to evaluate product quality and administration technique compliance."
    - name: "cold_chain_failure_count"
      expr: COUNT(CASE WHEN cold_chain_maintained = FALSE THEN 1 END)
      comment: "Count of vaccination events where cold chain was not maintained. Quality risk KPI — cold chain failures render vaccines ineffective and waste program investment."
    - name: "non_compliant_vaccination_count"
      expr: COUNT(CASE WHEN compliance_status != 'COMPLIANT' THEN 1 END)
      comment: "Count of vaccination records not in compliance status. Regulatory and biosecurity risk KPI — non-compliant records indicate gaps in herd immunity and potential audit findings."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`livestock_parturition_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Parturition (birth) performance metrics covering calving ease, offspring survival, and dam health outcomes. Supports reproductive program evaluation, genetic selection, and neonatal care protocol effectiveness."
  source: "`agriculture_ecm`.`livestock`.`parturition_record`"
  dimensions:
    - name: "birth_type"
      expr: birth_type
      comment: "Type of birth (single, twin, triplet) for litter size analysis and dam management planning."
    - name: "breeding_method"
      expr: breeding_method
      comment: "Breeding method that produced the offspring (AI, natural service, ET) for method-level reproductive outcome analysis."
    - name: "species_code"
      expr: species_code
      comment: "Species code for cross-species parturition performance benchmarking."
    - name: "dystocia_flag"
      expr: dystocia_flag
      comment: "Indicates difficult birth (dystocia) — high dystocia rates increase labor costs, calf mortality, and dam health risks."
    - name: "veterinary_intervention"
      expr: veterinary_intervention
      comment: "Indicates whether veterinary intervention was required at birth — tracks intervention rate for protocol and genetic selection decisions."
    - name: "colostrum_administered"
      expr: colostrum_administered
      comment: "Indicates whether colostrum was administered to the newborn — critical for passive immunity transfer and neonatal survival."
    - name: "season_code"
      expr: season_code
      comment: "Season of birth for seasonal calving pattern analysis and resource planning."
    - name: "birth_date_month"
      expr: DATE_TRUNC('MONTH', birth_date)
      comment: "Month of birth for calving distribution analysis and seasonal labor planning."
    - name: "record_status"
      expr: record_status
      comment: "Status of the parturition record (complete, pending, voided) for data quality filtering."
  measures:
    - name: "total_parturition_events"
      expr: COUNT(1)
      comment: "Total number of parturition events. Baseline reproductive output metric for herd growth and replacement rate planning."
    - name: "avg_birth_weight_kg"
      expr: AVG(CAST(birth_weight_kg AS DOUBLE))
      comment: "Average birth weight in kg. Genetic performance indicator — birth weight EPD accuracy validation and neonatal survival predictor."
    - name: "dystocia_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dystocia_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of births with dystocia. Key reproductive and welfare KPI — high dystocia rates increase calf mortality, dam culling, and labor costs, and trigger sire selection review."
    - name: "veterinary_intervention_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN veterinary_intervention = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of births requiring veterinary intervention. Labor and cost KPI — high rates indicate genetic or management issues requiring corrective action."
    - name: "avg_dam_body_condition_score"
      expr: AVG(CAST(dam_body_condition_score AS DOUBLE))
      comment: "Average dam body condition score at parturition. Nutritional management KPI — poor BCS at calving is associated with increased dystocia, reduced milk production, and delayed rebreeding."
    - name: "avg_colostrum_volume_ml"
      expr: AVG(CAST(colostrum_volume_ml AS DOUBLE))
      comment: "Average colostrum volume administered to newborns in ml. Neonatal health KPI — adequate colostrum intake is the single most important factor in neonatal survival and lifetime health."
    - name: "avg_placenta_expulsion_hours"
      expr: AVG(CAST(placenta_expulsion_hours AS DOUBLE))
      comment: "Average hours to placenta expulsion post-partum. Dam health KPI — retained placenta (>12 hours) increases metritis risk and reduces rebreeding performance."
    - name: "colostrum_administered_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN colostrum_administered = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of newborns that received colostrum. Neonatal care compliance KPI — directly linked to passive immunity transfer rates and pre-weaning mortality."
$$;