-- Metric views for domain: discovery | Business: Pharmaceuticals | Version: 1 | Generated on: 2026-05-05 17:46:18

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`discovery_compound`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core compound metrics tracking molecular properties, registration, and discovery stage progression for drug candidates"
  source: "`pharmaceuticals_ecm`.`discovery`.`compound`"
  dimensions:
    - name: "compound_status"
      expr: compound_status
      comment: "Current status of the compound in the discovery pipeline"
    - name: "discovery_stage"
      expr: discovery_stage
      comment: "Stage of discovery process (e.g., hit, lead, candidate)"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area the compound targets"
    - name: "compound_class"
      expr: compound_class
      comment: "Chemical classification of the compound"
    - name: "source_type"
      expr: source_type
      comment: "Origin of the compound (e.g., internal synthesis, external vendor, natural product)"
    - name: "mechanism_of_action"
      expr: mechanism_of_action
      comment: "Mechanism by which the compound produces its therapeutic effect"
    - name: "registration_year"
      expr: YEAR(registration_date)
      comment: "Year the compound was registered in the system"
    - name: "registration_quarter"
      expr: CONCAT('Q', QUARTER(registration_date), '-', YEAR(registration_date))
      comment: "Quarter and year of compound registration"
    - name: "glp_compliant"
      expr: glp_compliant
      comment: "Whether the compound meets Good Laboratory Practice standards"
    - name: "hazard_classification"
      expr: hazard_classification
      comment: "Safety hazard classification for handling and storage"
  measures:
    - name: "total_compounds"
      expr: COUNT(DISTINCT compound_id)
      comment: "Total number of unique compounds registered"
    - name: "avg_molecular_weight"
      expr: AVG(CAST(molecular_weight AS DOUBLE))
      comment: "Average molecular weight across compounds in Daltons"
    - name: "avg_logp"
      expr: AVG(CAST(logp AS DOUBLE))
      comment: "Average lipophilicity (logP) indicating drug-likeness"
    - name: "avg_purity_percent"
      expr: AVG(CAST(purity_percent AS DOUBLE))
      comment: "Average purity percentage of compound samples"
    - name: "avg_aqueous_solubility_um"
      expr: AVG(CAST(solubility_aqueous_um AS DOUBLE))
      comment: "Average aqueous solubility in micromolar, critical for bioavailability"
    - name: "avg_tpsa"
      expr: AVG(CAST(tpsa_angstrom2 AS DOUBLE))
      comment: "Average topological polar surface area in Angstrom squared, predicting membrane permeability"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`discovery_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discovery project portfolio metrics tracking strategic initiatives, phase progression, and portfolio decisions"
  source: "`pharmaceuticals_ecm`.`discovery`.`project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current status of the discovery project"
    - name: "phase"
      expr: phase
      comment: "Discovery phase (e.g., target validation, hit-to-lead, lead optimization)"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area focus of the project"
    - name: "modality"
      expr: modality
      comment: "Drug modality (e.g., small molecule, biologic, gene therapy)"
    - name: "strategic_priority_tier"
      expr: strategic_priority_tier
      comment: "Strategic importance tier assigned to the project"
    - name: "portfolio_decision"
      expr: portfolio_decision
      comment: "Latest portfolio review decision (e.g., advance, hold, terminate)"
    - name: "collaboration_type"
      expr: collaboration_type
      comment: "Type of external collaboration if applicable"
    - name: "project_type"
      expr: project_type
      comment: "Classification of project type"
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year the project was initiated"
    - name: "glp_compliance_flag"
      expr: glp_compliance_flag
      comment: "Whether the project adheres to Good Laboratory Practice standards"
    - name: "external_collaboration_flag"
      expr: external_collaboration_flag
      comment: "Whether the project involves external partners"
  measures:
    - name: "total_projects"
      expr: COUNT(DISTINCT project_id)
      comment: "Total number of discovery projects in portfolio"
    - name: "active_projects"
      expr: COUNT(DISTINCT CASE WHEN project_status IN ('Active', 'In Progress', 'Ongoing') THEN project_id END)
      comment: "Number of currently active discovery projects"
    - name: "projects_with_external_collaboration"
      expr: COUNT(DISTINCT CASE WHEN external_collaboration_flag = TRUE THEN project_id END)
      comment: "Number of projects involving external partnerships"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`discovery_hts_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High-throughput screening campaign performance metrics tracking screening efficiency, hit rates, and data quality"
  source: "`pharmaceuticals_ecm`.`discovery`.`hts_campaign`"
  dimensions:
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the HTS campaign"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area targeted by the screening campaign"
    - name: "screen_type"
      expr: screen_type
      comment: "Type of screen (e.g., primary, confirmatory, counter-screen)"
    - name: "target_class"
      expr: target_class
      comment: "Class of molecular target being screened"
    - name: "assay_technology"
      expr: assay_technology
      comment: "Technology platform used for screening"
    - name: "plate_format"
      expr: plate_format
      comment: "Microplate format used (e.g., 96-well, 384-well, 1536-well)"
    - name: "cro_involved"
      expr: cro_involved
      comment: "Whether a contract research organization was involved"
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Overall data quality assessment flag"
    - name: "campaign_year"
      expr: YEAR(actual_start_date)
      comment: "Year the campaign was initiated"
    - name: "glp_compliant"
      expr: glp_compliant
      comment: "Whether the campaign meets Good Laboratory Practice standards"
  measures:
    - name: "total_campaigns"
      expr: COUNT(DISTINCT hts_campaign_id)
      comment: "Total number of HTS campaigns executed"
    - name: "avg_hit_rate_percent"
      expr: AVG(CAST(hit_rate_percent AS DOUBLE))
      comment: "Average hit rate percentage across campaigns, indicating screening success"
    - name: "avg_z_prime_factor"
      expr: AVG(CAST(z_prime_factor AS DOUBLE))
      comment: "Average Z-prime factor indicating assay quality and signal separation"
    - name: "avg_signal_to_background_ratio"
      expr: AVG(CAST(signal_to_background_ratio AS DOUBLE))
      comment: "Average signal-to-background ratio measuring assay robustness"
    - name: "avg_coefficient_of_variation_percent"
      expr: AVG(CAST(coefficient_of_variation_percent AS DOUBLE))
      comment: "Average coefficient of variation indicating assay reproducibility"
    - name: "total_compounds_screened"
      expr: SUM(CAST(REGEXP_REPLACE(compounds_screened_count, '[^0-9]', '') AS BIGINT))
      comment: "Total number of compounds screened across all campaigns"
    - name: "total_hits_identified"
      expr: SUM(CAST(REGEXP_REPLACE(hit_count, '[^0-9]', '') AS BIGINT))
      comment: "Total number of hits identified across all campaigns"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`discovery_lead_series`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead series progression metrics tracking chemical series optimization, drug-likeness, and advancement decisions"
  source: "`pharmaceuticals_ecm`.`discovery`.`lead_series`"
  dimensions:
    - name: "series_status"
      expr: series_status
      comment: "Current status of the lead series"
    - name: "current_stage"
      expr: current_stage
      comment: "Current development stage of the series"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area targeted by the lead series"
    - name: "modality"
      expr: modality
      comment: "Drug modality of the series"
    - name: "nce_nbe_classification"
      expr: nce_nbe_classification
      comment: "Classification as New Chemical Entity or New Biological Entity"
    - name: "ip_status"
      expr: ip_status
      comment: "Intellectual property status of the series"
    - name: "stage_gate_decision"
      expr: stage_gate_decision
      comment: "Latest stage-gate decision (e.g., advance, hold, terminate)"
    - name: "sar_maturity_level"
      expr: sar_maturity_level
      comment: "Maturity level of structure-activity relationship understanding"
    - name: "safety_flag"
      expr: safety_flag
      comment: "Whether safety concerns have been identified"
    - name: "nomination_year"
      expr: YEAR(nomination_date)
      comment: "Year the series was nominated for advancement"
    - name: "glp_compliant"
      expr: glp_compliant
      comment: "Whether the series meets Good Laboratory Practice standards"
  measures:
    - name: "total_lead_series"
      expr: COUNT(DISTINCT lead_series_id)
      comment: "Total number of lead series under development"
    - name: "avg_drug_likeness_score"
      expr: AVG(CAST(drug_likeness_score AS DOUBLE))
      comment: "Average drug-likeness score predicting development success probability"
    - name: "avg_oral_bioavailability_pct"
      expr: AVG(CAST(oral_bioavailability_pct AS DOUBLE))
      comment: "Average oral bioavailability percentage, critical for oral drug development"
    - name: "avg_potency_benchmark_nm"
      expr: AVG(CAST(potency_benchmark_nm AS DOUBLE))
      comment: "Average potency benchmark in nanomolar, indicating target engagement strength"
    - name: "avg_molecular_weight_da"
      expr: AVG(CAST(molecular_weight_da AS DOUBLE))
      comment: "Average molecular weight in Daltons for the series"
    - name: "series_with_safety_flags"
      expr: COUNT(DISTINCT CASE WHEN safety_flag = TRUE THEN lead_series_id END)
      comment: "Number of series with identified safety concerns requiring mitigation"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`discovery_candidate_nomination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Candidate nomination decision metrics tracking progression from discovery to development with regulatory readiness"
  source: "`pharmaceuticals_ecm`.`discovery`.`candidate_nomination`"
  dimensions:
    - name: "nomination_status"
      expr: nomination_status
      comment: "Current status of the candidate nomination"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the nominated candidate"
    - name: "modality"
      expr: modality
      comment: "Drug modality of the candidate"
    - name: "nce_nbe_classification"
      expr: nce_nbe_classification
      comment: "Classification as New Chemical Entity or New Biological Entity"
    - name: "regulatory_pathway"
      expr: regulatory_pathway
      comment: "Intended regulatory pathway (e.g., 505(b)(1), 505(b)(2), BLA)"
    - name: "portfolio_priority"
      expr: portfolio_priority
      comment: "Strategic portfolio priority tier"
    - name: "first_in_class"
      expr: first_in_class
      comment: "Whether the candidate represents a first-in-class mechanism"
    - name: "orphan_drug_eligible"
      expr: orphan_drug_eligible
      comment: "Whether the candidate qualifies for orphan drug designation"
    - name: "nomination_year"
      expr: YEAR(nomination_date)
      comment: "Year the candidate was nominated"
    - name: "decision_year"
      expr: YEAR(decision_date)
      comment: "Year the nomination decision was made"
    - name: "glp_compliant"
      expr: glp_compliant
      comment: "Whether the candidate meets Good Laboratory Practice standards"
  measures:
    - name: "total_nominations"
      expr: COUNT(DISTINCT candidate_nomination_id)
      comment: "Total number of candidate nominations submitted"
    - name: "approved_nominations"
      expr: COUNT(DISTINCT CASE WHEN nomination_status IN ('Approved', 'Advanced') THEN candidate_nomination_id END)
      comment: "Number of nominations approved for development progression"
    - name: "first_in_class_candidates"
      expr: COUNT(DISTINCT CASE WHEN first_in_class = TRUE THEN candidate_nomination_id END)
      comment: "Number of first-in-class candidates with novel mechanisms"
    - name: "orphan_drug_candidates"
      expr: COUNT(DISTINCT CASE WHEN orphan_drug_eligible = TRUE THEN candidate_nomination_id END)
      comment: "Number of candidates eligible for orphan drug designation"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`discovery_in_vivo_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "In vivo study performance metrics tracking efficacy, pharmacokinetics, and safety in animal models"
  source: "`pharmaceuticals_ecm`.`discovery`.`in_vivo_study`"
  dimensions:
    - name: "study_status"
      expr: study_status
      comment: "Current status of the in vivo study"
    - name: "study_type"
      expr: study_type
      comment: "Type of in vivo study (e.g., efficacy, PK, toxicology)"
    - name: "study_phase"
      expr: study_phase
      comment: "Phase of preclinical development"
    - name: "animal_species"
      expr: animal_species
      comment: "Species used in the study"
    - name: "animal_sex"
      expr: animal_sex
      comment: "Sex of animals used"
    - name: "dose_route"
      expr: dose_route
      comment: "Route of administration (e.g., oral, IV, SC)"
    - name: "glp_compliant"
      expr: glp_compliant
      comment: "Whether the study meets Good Laboratory Practice standards"
    - name: "cro_flag"
      expr: cro_flag
      comment: "Whether the study was conducted by a contract research organization"
    - name: "study_year"
      expr: YEAR(start_date)
      comment: "Year the study was initiated"
  measures:
    - name: "total_in_vivo_studies"
      expr: COUNT(DISTINCT in_vivo_study_id)
      comment: "Total number of in vivo studies conducted"
    - name: "avg_pk_bioavailability_pct"
      expr: AVG(CAST(pk_bioavailability_pct AS DOUBLE))
      comment: "Average pharmacokinetic bioavailability percentage across studies"
    - name: "avg_pk_half_life_h"
      expr: AVG(CAST(pk_half_life_h AS DOUBLE))
      comment: "Average pharmacokinetic half-life in hours"
    - name: "avg_pk_clearance_ml_min_kg"
      expr: AVG(CAST(pk_clearance_ml_min_kg AS DOUBLE))
      comment: "Average clearance rate in mL/min/kg, indicating drug elimination"
    - name: "avg_pk_cmax_ng_ml"
      expr: AVG(CAST(pk_cmax_ng_ml AS DOUBLE))
      comment: "Average maximum plasma concentration in ng/mL"
    - name: "avg_pk_auc_ng_ml_h"
      expr: AVG(CAST(pk_auc_ng_ml_h AS DOUBLE))
      comment: "Average area under the curve in ng·mL/h, measuring total drug exposure"
    - name: "avg_noael_mg_kg"
      expr: AVG(CAST(noael_mg_kg AS DOUBLE))
      comment: "Average no-observed-adverse-effect level in mg/kg, critical for safety margin"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`discovery_adme_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ADME profiling metrics tracking absorption, distribution, metabolism, and excretion properties critical for drug development"
  source: "`pharmaceuticals_ecm`.`discovery`.`adme_profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the ADME profile"
    - name: "metabolic_stability_class"
      expr: metabolic_stability_class
      comment: "Classification of metabolic stability (e.g., high, medium, low)"
    - name: "species"
      expr: species
      comment: "Species used for ADME testing"
    - name: "bbb_penetration"
      expr: bbb_penetration
      comment: "Whether the compound penetrates the blood-brain barrier"
    - name: "pgp_substrate"
      expr: pgp_substrate
      comment: "Whether the compound is a P-glycoprotein substrate"
    - name: "cyp_inhibition_flag"
      expr: cyp_inhibition_flag
      comment: "Whether the compound inhibits cytochrome P450 enzymes"
    - name: "progression_recommendation"
      expr: progression_recommendation
      comment: "Recommendation for compound progression based on ADME profile"
    - name: "ppb_method"
      expr: ppb_method
      comment: "Method used for plasma protein binding measurement"
    - name: "solubility_method"
      expr: solubility_method
      comment: "Method used for solubility measurement"
    - name: "assay_year"
      expr: YEAR(assay_date)
      comment: "Year the ADME assay was performed"
  measures:
    - name: "total_adme_profiles"
      expr: COUNT(DISTINCT adme_profile_id)
      comment: "Total number of ADME profiles generated"
    - name: "avg_bioavailability_pct"
      expr: AVG(CAST(bioavailability_pct AS DOUBLE))
      comment: "Average oral bioavailability percentage, critical for oral drug viability"
    - name: "avg_permeability_caco2_nm_s"
      expr: AVG(CAST(permeability_caco2_nm_s AS DOUBLE))
      comment: "Average Caco-2 permeability in nm/s, predicting intestinal absorption"
    - name: "avg_plasma_protein_binding_pct"
      expr: AVG(CAST(plasma_protein_binding_pct AS DOUBLE))
      comment: "Average plasma protein binding percentage, affecting free drug concentration"
    - name: "avg_clearance_ml_min_kg"
      expr: AVG(CAST(clearance_ml_min_kg AS DOUBLE))
      comment: "Average clearance rate in mL/min/kg"
    - name: "avg_half_life_h"
      expr: AVG(CAST(half_life_h AS DOUBLE))
      comment: "Average elimination half-life in hours"
    - name: "avg_volume_of_distribution_l_kg"
      expr: AVG(CAST(volume_of_distribution_l_kg AS DOUBLE))
      comment: "Average volume of distribution in L/kg, indicating tissue distribution"
    - name: "avg_solubility_um"
      expr: AVG(CAST(solubility_um AS DOUBLE))
      comment: "Average solubility in micromolar"
    - name: "avg_adme_risk_score"
      expr: AVG(CAST(adme_risk_score AS DOUBLE))
      comment: "Average ADME risk score indicating development risk"
    - name: "compounds_with_bbb_penetration"
      expr: COUNT(DISTINCT CASE WHEN bbb_penetration = TRUE THEN adme_profile_id END)
      comment: "Number of compounds with blood-brain barrier penetration capability"
    - name: "compounds_with_cyp_inhibition"
      expr: COUNT(DISTINCT CASE WHEN cyp_inhibition_flag = TRUE THEN adme_profile_id END)
      comment: "Number of compounds with CYP inhibition, indicating drug-drug interaction risk"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`discovery_molecular_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Molecular target portfolio metrics tracking target validation, druggability, and competitive landscape"
  source: "`pharmaceuticals_ecm`.`discovery`.`molecular_target`"
  dimensions:
    - name: "target_class"
      expr: target_class
      comment: "Class of molecular target (e.g., kinase, GPCR, ion channel)"
    - name: "target_type"
      expr: target_type
      comment: "Type of target (e.g., protein, RNA, DNA)"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area associated with the target"
    - name: "validation_status"
      expr: validation_status
      comment: "Current validation status of the target"
    - name: "druggability_assessment"
      expr: druggability_assessment
      comment: "Assessment of target druggability (e.g., high, medium, low)"
    - name: "novelty_status"
      expr: novelty_status
      comment: "Novelty classification of the target"
    - name: "prioritization_tier"
      expr: prioritization_tier
      comment: "Strategic prioritization tier"
    - name: "moa_type"
      expr: moa_type
      comment: "Type of mechanism of action"
    - name: "modality"
      expr: modality
      comment: "Preferred drug modality for the target"
    - name: "safety_concern_flag"
      expr: safety_concern_flag
      comment: "Whether safety concerns have been identified"
    - name: "protein_structure_available"
      expr: protein_structure_available
      comment: "Whether protein structure is available for structure-based design"
    - name: "organism"
      expr: organism
      comment: "Organism source of the target"
  measures:
    - name: "total_molecular_targets"
      expr: COUNT(DISTINCT molecular_target_id)
      comment: "Total number of molecular targets in the portfolio"
    - name: "validated_targets"
      expr: COUNT(DISTINCT CASE WHEN validation_status IN ('Validated', 'Clinically Validated') THEN molecular_target_id END)
      comment: "Number of validated targets ready for drug discovery"
    - name: "targets_with_structure"
      expr: COUNT(DISTINCT CASE WHEN protein_structure_available = TRUE THEN molecular_target_id END)
      comment: "Number of targets with available protein structure for rational design"
    - name: "targets_with_safety_concerns"
      expr: COUNT(DISTINCT CASE WHEN safety_concern_flag = TRUE THEN molecular_target_id END)
      comment: "Number of targets with identified safety concerns requiring mitigation"
    - name: "avg_genetic_association_score"
      expr: AVG(CAST(genetic_association_score AS DOUBLE))
      comment: "Average genetic association score indicating target-disease linkage strength"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`discovery_sar_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Structure-activity relationship study metrics tracking medicinal chemistry optimization and patent strategy"
  source: "`pharmaceuticals_ecm`.`discovery`.`sar_study`"
  dimensions:
    - name: "study_status"
      expr: study_status
      comment: "Current status of the SAR study"
    - name: "study_phase"
      expr: study_phase
      comment: "Phase of the SAR study"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area focus of the SAR study"
    - name: "progression_decision"
      expr: progression_decision
      comment: "Decision on series progression based on SAR findings"
    - name: "nce_nbe_type"
      expr: nce_nbe_type
      comment: "Classification as New Chemical Entity or New Biological Entity"
    - name: "patent_filing_flag"
      expr: patent_filing_flag
      comment: "Whether a patent filing resulted from the SAR study"
    - name: "metabolic_stability_flag"
      expr: metabolic_stability_flag
      comment: "Whether metabolic stability was achieved"
    - name: "permeability_flag"
      expr: permeability_flag
      comment: "Whether adequate permeability was achieved"
    - name: "potency_metric_type"
      expr: potency_metric_type
      comment: "Type of potency metric used (e.g., IC50, EC50, Ki)"
    - name: "study_year"
      expr: YEAR(start_date)
      comment: "Year the SAR study was initiated"
    - name: "glp_compliant"
      expr: glp_compliant
      comment: "Whether the study meets Good Laboratory Practice standards"
  measures:
    - name: "total_sar_studies"
      expr: COUNT(DISTINCT sar_study_id)
      comment: "Total number of SAR studies conducted"
    - name: "avg_selectivity_ratio"
      expr: AVG(CAST(selectivity_ratio AS DOUBLE))
      comment: "Average selectivity ratio indicating target specificity"
    - name: "avg_potency_range_min_nm"
      expr: AVG(CAST(potency_range_min_nm AS DOUBLE))
      comment: "Average minimum potency achieved in nanomolar"
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score for SAR studies"
    - name: "studies_with_patent_filing"
      expr: COUNT(DISTINCT CASE WHEN patent_filing_flag = TRUE THEN sar_study_id END)
      comment: "Number of SAR studies resulting in patent filings, protecting IP"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`discovery_compound_synthesis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compound synthesis efficiency metrics tracking yield, purity, and synthetic route success"
  source: "`pharmaceuticals_ecm`.`discovery`.`compound_synthesis`"
  dimensions:
    - name: "synthesis_status"
      expr: synthesis_status
      comment: "Current status of the synthesis"
    - name: "synthesis_purpose"
      expr: synthesis_purpose
      comment: "Purpose of the synthesis (e.g., screening, scale-up, GMP)"
    - name: "compound_type"
      expr: compound_type
      comment: "Type of compound synthesized"
    - name: "synthetic_method"
      expr: synthetic_method
      comment: "Synthetic method employed"
    - name: "purification_method"
      expr: purification_method
      comment: "Method used for purification"
    - name: "structural_confirmation_method"
      expr: structural_confirmation_method
      comment: "Method used to confirm structure (e.g., NMR, MS)"
    - name: "hazard_classification"
      expr: hazard_classification
      comment: "Hazard classification of the synthesis"
    - name: "storage_condition"
      expr: storage_condition
      comment: "Required storage conditions"
    - name: "registered_in_library"
      expr: registered_in_library
      comment: "Whether the compound was registered in the compound library"
    - name: "synthesis_year"
      expr: YEAR(synthesis_date)
      comment: "Year the synthesis was performed"
    - name: "glp_compliant"
      expr: glp_compliant
      comment: "Whether the synthesis meets Good Laboratory Practice standards"
  measures:
    - name: "total_syntheses"
      expr: COUNT(DISTINCT compound_synthesis_id)
      comment: "Total number of compound syntheses performed"
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average synthesis yield percentage, indicating synthetic efficiency"
    - name: "avg_hplc_purity_percent"
      expr: AVG(CAST(hplc_purity_percent AS DOUBLE))
      comment: "Average HPLC purity percentage of synthesized compounds"
    - name: "avg_nmr_purity_percent"
      expr: AVG(CAST(nmr_purity_percent AS DOUBLE))
      comment: "Average NMR purity percentage"
    - name: "avg_product_mass_mg"
      expr: AVG(CAST(product_mass_mg AS DOUBLE))
      comment: "Average product mass in milligrams"
    - name: "avg_synthesis_scale_mmol"
      expr: AVG(CAST(synthesis_scale_mmol AS DOUBLE))
      comment: "Average synthesis scale in millimoles"
    - name: "avg_reaction_duration_hours"
      expr: AVG(CAST(reaction_duration_hours AS DOUBLE))
      comment: "Average reaction duration in hours"
    - name: "successful_syntheses"
      expr: COUNT(DISTINCT CASE WHEN synthesis_status IN ('Complete', 'Success', 'Approved') THEN compound_synthesis_id END)
      comment: "Number of successful syntheses"
$$;