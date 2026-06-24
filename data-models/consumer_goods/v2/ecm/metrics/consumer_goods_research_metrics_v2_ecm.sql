-- Metric views for domain: research | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-23 23:48:34

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_claim_substantiation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim Substantiation business metrics"
  source: "`vibe_consumer_goods_v1`.`research`.`claim_substantiation`"
  dimensions:
    - name: "Advertising Standard Compliance"
      expr: advertising_standard_compliance
    - name: "Challenge History"
      expr: challenge_history
    - name: "Channel Applicability"
      expr: channel_applicability
    - name: "Claim Approval Status"
      expr: claim_approval_status
    - name: "Claim Category"
      expr: claim_category
    - name: "Claim Code"
      expr: claim_code
    - name: "Claim Effective Date"
      expr: claim_effective_date
    - name: "Claim Expiry Date"
      expr: claim_expiry_date
    - name: "Claim Text"
      expr: claim_text
    - name: "Claim Type"
      expr: claim_type
    - name: "Clinical Study Reference"
      expr: clinical_study_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Efficacy Result Summary"
      expr: efficacy_result_summary
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Legal Review Date"
      expr: legal_review_date
    - name: "Legal Review Status"
      expr: legal_review_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Claim Substantiation"
      expr: COUNT(DISTINCT claim_substantiation_id)
    - name: "Total Confidence Level Percent"
      expr: SUM(confidence_level_percent)
    - name: "Average Confidence Level Percent"
      expr: AVG(confidence_level_percent)
    - name: "Total P Value"
      expr: SUM(p_value)
    - name: "Average P Value"
      expr: AVG(p_value)
    - name: "Total Substantiation Cost Amount"
      expr: SUM(substantiation_cost_amount)
    - name: "Average Substantiation Cost Amount"
      expr: AVG(substantiation_cost_amount)
    - name: "Total Substantiation Cost Currency"
      expr: SUM(substantiation_cost_currency)
    - name: "Average Substantiation Cost Currency"
      expr: AVG(substantiation_cost_currency)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_consumer_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consumer Test business metrics"
  source: "`vibe_consumer_goods_v1`.`research`.`consumer_test`"
  dimensions:
    - name: "Adverse Event Description"
      expr: adverse_event_description
    - name: "Adverse Event Reported"
      expr: adverse_event_reported
    - name: "Claim Substantiation Outcome"
      expr: claim_substantiation_outcome
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Ethics Committee Approval"
      expr: ethics_committee_approval
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Nps Score"
      expr: nps_score
    - name: "Open Text Verbatim"
      expr: open_text_verbatim
    - name: "Overall Study Outcome"
      expr: overall_study_outcome
    - name: "Primary Claim Tested"
      expr: primary_claim_tested
    - name: "Prototype Code"
      expr: prototype_code
    - name: "Purchase Intent Score"
      expr: purchase_intent_score
    - name: "Regulatory Approval Status"
      expr: regulatory_approval_status
    - name: "Sample Size"
      expr: sample_size
    - name: "Secondary Claims Tested"
      expr: secondary_claims_tested
    - name: "Statistical Significance Flag"
      expr: statistical_significance_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Consumer Test"
      expr: COUNT(DISTINCT consumer_test_id)
    - name: "Total Confidence Level"
      expr: SUM(confidence_level)
    - name: "Average Confidence Level"
      expr: AVG(confidence_level)
    - name: "Total Efficacy Perception Rating"
      expr: SUM(efficacy_perception_rating)
    - name: "Average Efficacy Perception Rating"
      expr: AVG(efficacy_perception_rating)
    - name: "Total Fragrance Rating"
      expr: SUM(fragrance_rating)
    - name: "Average Fragrance Rating"
      expr: AVG(fragrance_rating)
    - name: "Total Lather Rating"
      expr: SUM(lather_rating)
    - name: "Average Lather Rating"
      expr: AVG(lather_rating)
    - name: "Total Overall Satisfaction Rating"
      expr: SUM(overall_satisfaction_rating)
    - name: "Average Overall Satisfaction Rating"
      expr: AVG(overall_satisfaction_rating)
    - name: "Total P Value"
      expr: SUM(p_value)
    - name: "Average P Value"
      expr: AVG(p_value)
    - name: "Total Rating Scale Max"
      expr: SUM(rating_scale_max)
    - name: "Average Rating Scale Max"
      expr: AVG(rating_scale_max)
    - name: "Total Rating Scale Min"
      expr: SUM(rating_scale_min)
    - name: "Average Rating Scale Min"
      expr: AVG(rating_scale_min)
    - name: "Total Skin Feel Rating"
      expr: SUM(skin_feel_rating)
    - name: "Average Skin Feel Rating"
      expr: AVG(skin_feel_rating)
    - name: "Total Study Cost Amount"
      expr: SUM(study_cost_amount)
    - name: "Average Study Cost Amount"
      expr: AVG(study_cost_amount)
    - name: "Total Study Cost Currency"
      expr: SUM(study_cost_currency)
    - name: "Average Study Cost Currency"
      expr: AVG(study_cost_currency)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_consumer_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consumer Test Result business metrics"
  source: "`vibe_consumer_goods_v1`.`research`.`consumer_test_result`"
  dimensions:
    - name: "Adverse Event Description"
      expr: adverse_event_description
    - name: "Adverse Event Reported"
      expr: adverse_event_reported
    - name: "Attribute Tested"
      expr: attribute_tested
    - name: "Benchmark Comparison"
      expr: benchmark_comparison
    - name: "Claim Substantiation Outcome"
      expr: claim_substantiation_outcome
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Flag"
      expr: data_quality_flag
    - name: "Ethics Approval Number"
      expr: ethics_approval_number
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Nps Category"
      expr: nps_category
    - name: "Nps Score"
      expr: nps_score
    - name: "Principal Investigator"
      expr: principal_investigator
    - name: "Purchase Intent"
      expr: purchase_intent
    - name: "Rating Label"
      expr: rating_label
    - name: "Rating Scale Type"
      expr: rating_scale_type
    - name: "Regulatory Submission Included"
      expr: regulatory_submission_included
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Consumer Test Result"
      expr: COUNT(DISTINCT consumer_test_result_id)
    - name: "Total Compliance Rate"
      expr: SUM(compliance_rate)
    - name: "Average Compliance Rate"
      expr: AVG(compliance_rate)
    - name: "Total Confidence Level"
      expr: SUM(confidence_level)
    - name: "Average Confidence Level"
      expr: AVG(confidence_level)
    - name: "Total P Value"
      expr: SUM(p_value)
    - name: "Average P Value"
      expr: AVG(p_value)
    - name: "Total Rating Value"
      expr: SUM(rating_value)
    - name: "Average Rating Value"
      expr: AVG(rating_value)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_inci_library`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inci Library business metrics"
  source: "`vibe_consumer_goods_v1`.`research`.`inci_library`"
  dimensions:
    - name: "Allergen Flag"
      expr: allergen_flag
    - name: "Approval Date"
      expr: approval_date
    - name: "Cas Number"
      expr: cas_number
    - name: "Chemical Family"
      expr: chemical_family
    - name: "Color Specification"
      expr: color_specification
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Ec Number"
      expr: ec_number
    - name: "Function Class"
      expr: function_class
    - name: "Grade Quality Level"
      expr: grade_quality_level
    - name: "Halal Certified Flag"
      expr: halal_certified_flag
    - name: "Inci Name"
      expr: inci_name
    - name: "Kosher Certified Flag"
      expr: kosher_certified_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Natural Origin Flag"
      expr: natural_origin_flag
    - name: "Next Review Date"
      expr: next_review_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Inci Library"
      expr: COUNT(DISTINCT inci_library_id)
    - name: "Total Approved Concentration Max Percentage"
      expr: SUM(approved_concentration_max_percentage)
    - name: "Average Approved Concentration Max Percentage"
      expr: AVG(approved_concentration_max_percentage)
    - name: "Total Approved Concentration Min Percentage"
      expr: SUM(approved_concentration_min_percentage)
    - name: "Average Approved Concentration Min Percentage"
      expr: AVG(approved_concentration_min_percentage)
    - name: "Total Maximum Permitted Concentration Percentage"
      expr: SUM(maximum_permitted_concentration_percentage)
    - name: "Average Maximum Permitted Concentration Percentage"
      expr: AVG(maximum_permitted_concentration_percentage)
    - name: "Total Moisture Content Max Percentage"
      expr: SUM(moisture_content_max_percentage)
    - name: "Average Moisture Content Max Percentage"
      expr: AVG(moisture_content_max_percentage)
    - name: "Total Purity Percentage"
      expr: SUM(purity_percentage)
    - name: "Average Purity Percentage"
      expr: AVG(purity_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_innovation_brief`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Innovation Brief business metrics"
  source: "`vibe_consumer_goods_v1`.`research`.`innovation_brief`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Attachments Reference"
      expr: attachments_reference
    - name: "Brief Code"
      expr: brief_code
    - name: "Brief Status"
      expr: brief_status
    - name: "Brief Title"
      expr: brief_title
    - name: "Brief Type"
      expr: brief_type
    - name: "Business Opportunity Description"
      expr: business_opportunity_description
    - name: "Competitive Benchmark Products"
      expr: competitive_benchmark_products
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Desired Product Benefits"
      expr: desired_product_benefits
    - name: "Innovation Priority Tier"
      expr: innovation_priority_tier
    - name: "Key Performance Indicators"
      expr: key_performance_indicators
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Market Size Currency Code"
      expr: market_size_currency_code
    - name: "Npv Currency Code"
      expr: npv_currency_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Innovation Brief"
      expr: COUNT(DISTINCT innovation_brief_id)
    - name: "Total Budget Currency Code"
      expr: SUM(budget_currency_code)
    - name: "Average Budget Currency Code"
      expr: AVG(budget_currency_code)
    - name: "Total Estimated Development Budget"
      expr: SUM(estimated_development_budget)
    - name: "Average Estimated Development Budget"
      expr: AVG(estimated_development_budget)
    - name: "Total Estimated Market Size"
      expr: SUM(estimated_market_size)
    - name: "Average Estimated Market Size"
      expr: AVG(estimated_market_size)
    - name: "Total Estimated Npv"
      expr: SUM(estimated_npv)
    - name: "Average Estimated Npv"
      expr: AVG(estimated_npv)
    - name: "Total Estimated Roi Percent"
      expr: SUM(estimated_roi_percent)
    - name: "Average Estimated Roi Percent"
      expr: AVG(estimated_roi_percent)
    - name: "Total Strategic Fit Rationale"
      expr: SUM(strategic_fit_rationale)
    - name: "Average Strategic Fit Rationale"
      expr: AVG(strategic_fit_rationale)
    - name: "Total Sustainability Target Score"
      expr: SUM(sustainability_target_score)
    - name: "Average Sustainability Target Score"
      expr: AVG(sustainability_target_score)
    - name: "Total Target Cogs"
      expr: SUM(target_cogs)
    - name: "Average Target Cogs"
      expr: AVG(target_cogs)
    - name: "Total Target Gross Margin Percent"
      expr: SUM(target_gross_margin_percent)
    - name: "Average Target Gross Margin Percent"
      expr: AVG(target_gross_margin_percent)
    - name: "Total Target Rsp"
      expr: SUM(target_rsp)
    - name: "Average Target Rsp"
      expr: AVG(target_rsp)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_lab_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lab Test business metrics"
  source: "`vibe_consumer_goods_v1`.`research`.`lab_test`"
  dimensions:
    - name: "Analyst Name"
      expr: analyst_name
    - name: "Calibration Date"
      expr: calibration_date
    - name: "Comments"
      expr: comments
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Lab Location"
      expr: lab_location
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Oos Flag"
      expr: oos_flag
    - name: "Pass Fail Status"
      expr: pass_fail_status
    - name: "Regulatory Flag"
      expr: regulatory_flag
    - name: "Result Text"
      expr: result_text
    - name: "Result Unit"
      expr: result_unit
    - name: "Retest Flag"
      expr: retest_flag
    - name: "Review Date"
      expr: review_date
    - name: "Reviewer Name"
      expr: reviewer_name
    - name: "Stability Timepoint"
      expr: stability_timepoint
    - name: "Storage Condition"
      expr: storage_condition
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Lab Test"
      expr: COUNT(DISTINCT lab_test_id)
    - name: "Total Result Value"
      expr: SUM(result_value)
    - name: "Average Result Value"
      expr: AVG(result_value)
    - name: "Total Specification Max"
      expr: SUM(specification_max)
    - name: "Average Specification Max"
      expr: AVG(specification_max)
    - name: "Total Specification Min"
      expr: SUM(specification_min)
    - name: "Average Specification Min"
      expr: AVG(specification_min)
    - name: "Total Specification Target"
      expr: SUM(specification_target)
    - name: "Average Specification Target"
      expr: AVG(specification_target)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_panel_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Panel Session business metrics"
  source: "`vibe_consumer_goods_v1`.`research`.`panel_session`"
  dimensions:
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Collection Method"
      expr: data_collection_method
    - name: "Panel Session Description"
      expr: panel_session_description
    - name: "Device Type"
      expr: device_type
    - name: "Duration Minutes"
      expr: duration_minutes
    - name: "End Timestamp"
      expr: end_timestamp
    - name: "Language"
      expr: language
    - name: "Location"
      expr: location
    - name: "Moderator Name"
      expr: moderator_name
    - name: "Notes"
      expr: notes
    - name: "Recruitment Method"
      expr: recruitment_method
    - name: "Sample Size"
      expr: sample_size
    - name: "Session Code"
      expr: session_code
    - name: "Session Name"
      expr: session_name
    - name: "Session Type"
      expr: session_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Panel Session"
      expr: COUNT(DISTINCT panel_session_id)
    - name: "Total Incentive Amount"
      expr: SUM(incentive_amount)
    - name: "Average Incentive Amount"
      expr: AVG(incentive_amount)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_patent_family`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patent Family business metrics"
  source: "`vibe_consumer_goods_v1`.`research`.`patent_family`"
  dimensions:
    - name: "Assignee Name"
      expr: assignee_name
    - name: "Confidentiality Expiry Date"
      expr: confidentiality_expiry_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Patent Family Description"
      expr: patent_family_description
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Family Code"
      expr: family_code
    - name: "Family Name"
      expr: family_name
    - name: "Family Type"
      expr: family_type
    - name: "Filing Date"
      expr: filing_date
    - name: "Grant Date"
      expr: grant_date
    - name: "Ipc Classification"
      expr: ipc_classification
    - name: "Is Confidential"
      expr: is_confidential
    - name: "Jurisdiction"
      expr: jurisdiction
    - name: "Keywords"
      expr: keywords
    - name: "Licensing Status"
      expr: licensing_status
    - name: "Market Region"
      expr: market_region
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Patent Family"
      expr: COUNT(DISTINCT patent_family_id)
    - name: "Total Assignee Code"
      expr: SUM(assignee_code)
    - name: "Average Assignee Code"
      expr: AVG(assignee_code)
    - name: "Total Royalty Currency"
      expr: SUM(royalty_currency)
    - name: "Average Royalty Currency"
      expr: AVG(royalty_currency)
    - name: "Total Royalty Rate"
      expr: SUM(royalty_rate)
    - name: "Average Royalty Rate"
      expr: AVG(royalty_rate)
    - name: "Total Strategic Importance Score"
      expr: SUM(strategic_importance_score)
    - name: "Average Strategic Importance Score"
      expr: AVG(strategic_importance_score)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_patent_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patent Filing business metrics"
  source: "`vibe_consumer_goods_v1`.`research`.`patent_filing`"
  dimensions:
    - name: "Abstract"
      expr: abstract
    - name: "Application Number"
      expr: application_number
    - name: "Assignee Country Code"
      expr: assignee_country_code
    - name: "Assignee Name"
      expr: assignee_name
    - name: "Backward Citations Count"
      expr: backward_citations_count
    - name: "Claims Count"
      expr: claims_count
    - name: "Cpc Class"
      expr: cpc_class
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Filing Date"
      expr: filing_date
    - name: "Forward Citations Count"
      expr: forward_citations_count
    - name: "Grant Date"
      expr: grant_date
    - name: "Independent Claims Count"
      expr: independent_claims_count
    - name: "Internal Reference Code"
      expr: internal_reference_code
    - name: "Inventors List"
      expr: inventors_list
    - name: "Jurisdiction Code"
      expr: jurisdiction_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Patent Filing"
      expr: COUNT(DISTINCT patent_filing_id)
    - name: "Total Commercial Value Tier"
      expr: SUM(commercial_value_tier)
    - name: "Average Commercial Value Tier"
      expr: AVG(commercial_value_tier)
    - name: "Total Cost Currency Code"
      expr: SUM(cost_currency_code)
    - name: "Average Cost Currency Code"
      expr: AVG(cost_currency_code)
    - name: "Total Estimated Annual Maintenance Cost"
      expr: SUM(estimated_annual_maintenance_cost)
    - name: "Average Estimated Annual Maintenance Cost"
      expr: AVG(estimated_annual_maintenance_cost)
    - name: "Total Freedom To Operate Status"
      expr: SUM(freedom_to_operate_status)
    - name: "Average Freedom To Operate Status"
      expr: AVG(freedom_to_operate_status)
    - name: "Total Pct Application Number"
      expr: SUM(pct_application_number)
    - name: "Average Pct Application Number"
      expr: AVG(pct_application_number)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_prototype`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prototype business metrics"
  source: "`vibe_consumer_goods_v1`.`research`.`prototype`"
  dimensions:
    - name: "Closure Type"
      expr: closure_type
    - name: "Prototype Code"
      expr: prototype_code
    - name: "Compatibility Test Completion Date"
      expr: compatibility_test_completion_date
    - name: "Consumer Test Eligible Flag"
      expr: consumer_test_eligible_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Formulation Compatibility Test Status"
      expr: formulation_compatibility_test_status
    - name: "Manufacturing Scale"
      expr: manufacturing_scale
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Prototype Name"
      expr: prototype_name
    - name: "Notes"
      expr: notes
    - name: "Packaging Approval Date"
      expr: packaging_approval_date
    - name: "Packaging Approved By"
      expr: packaging_approved_by
    - name: "Packaging Configuration Code"
      expr: packaging_configuration_code
    - name: "Primary Container Material"
      expr: primary_container_material
    - name: "Primary Container Type"
      expr: primary_container_type
    - name: "Prototype Status"
      expr: prototype_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Prototype"
      expr: COUNT(DISTINCT prototype_id)
    - name: "Total Container Capacity Ml"
      expr: SUM(container_capacity_ml)
    - name: "Average Container Capacity Ml"
      expr: AVG(container_capacity_ml)
    - name: "Total Container Diameter Mm"
      expr: SUM(container_diameter_mm)
    - name: "Average Container Diameter Mm"
      expr: AVG(container_diameter_mm)
    - name: "Total Container Height Mm"
      expr: SUM(container_height_mm)
    - name: "Average Container Height Mm"
      expr: AVG(container_height_mm)
    - name: "Total Container Weight Grams"
      expr: SUM(container_weight_grams)
    - name: "Average Container Weight Grams"
      expr: AVG(container_weight_grams)
    - name: "Total Decoration Method"
      expr: SUM(decoration_method)
    - name: "Average Decoration Method"
      expr: AVG(decoration_method)
    - name: "Total Estimated Packaging Cost"
      expr: SUM(estimated_packaging_cost)
    - name: "Average Estimated Packaging Cost"
      expr: AVG(estimated_packaging_cost)
    - name: "Total Fill Volume Ml"
      expr: SUM(fill_volume_ml)
    - name: "Average Fill Volume Ml"
      expr: AVG(fill_volume_ml)
    - name: "Total Fill Weight"
      expr: SUM(fill_weight)
    - name: "Average Fill Weight"
      expr: AVG(fill_weight)
    - name: "Total Generation"
      expr: SUM(generation)
    - name: "Average Generation"
      expr: AVG(generation)
    - name: "Total Packaging Cost Currency Code"
      expr: SUM(packaging_cost_currency_code)
    - name: "Average Packaging Cost Currency Code"
      expr: AVG(packaging_cost_currency_code)
    - name: "Total Recycled Content Percent"
      expr: SUM(recycled_content_percent)
    - name: "Average Recycled Content Percent"
      expr: AVG(recycled_content_percent)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_raw_material_spec`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Raw Material Spec business metrics"
  source: "`vibe_consumer_goods_v1`.`research`.`raw_material_spec`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Einecs Number"
      expr: einecs_number
    - name: "Eu Restricted Flag"
      expr: eu_restricted_flag
    - name: "Hazard Classification"
      expr: hazard_classification
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Material Name"
      expr: material_name
    - name: "Notes"
      expr: notes
    - name: "Organic Certified Flag"
      expr: organic_certified_flag
    - name: "Palm Oil Derivative Flag"
      expr: palm_oil_derivative_flag
    - name: "Raw Material Code"
      expr: raw_material_code
    - name: "Rd Approval Status"
      expr: rd_approval_status
    - name: "Regulatory Classification"
      expr: regulatory_classification
    - name: "Sds Available Flag"
      expr: sds_available_flag
    - name: "Shelf Life Months"
      expr: shelf_life_months
    - name: "Specification Version"
      expr: specification_version
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Raw Material Spec"
      expr: COUNT(DISTINCT raw_material_spec_id)
    - name: "Total Approved Concentration Max Percent"
      expr: SUM(approved_concentration_max_percent)
    - name: "Average Approved Concentration Max Percent"
      expr: AVG(approved_concentration_max_percent)
    - name: "Total Approved Concentration Min Percent"
      expr: SUM(approved_concentration_min_percent)
    - name: "Average Approved Concentration Min Percent"
      expr: AVG(approved_concentration_min_percent)
    - name: "Total Cost Currency Code"
      expr: SUM(cost_currency_code)
    - name: "Average Cost Currency Code"
      expr: AVG(cost_currency_code)
    - name: "Total Cost Per Kg"
      expr: SUM(cost_per_kg)
    - name: "Average Cost Per Kg"
      expr: AVG(cost_per_kg)
    - name: "Total Eu Maximum Concentration Percent"
      expr: SUM(eu_maximum_concentration_percent)
    - name: "Average Eu Maximum Concentration Percent"
      expr: AVG(eu_maximum_concentration_percent)
    - name: "Total Moisture Content Percent"
      expr: SUM(moisture_content_percent)
    - name: "Average Moisture Content Percent"
      expr: AVG(moisture_content_percent)
    - name: "Total Particle Size Microns"
      expr: SUM(particle_size_microns)
    - name: "Average Particle Size Microns"
      expr: AVG(particle_size_microns)
    - name: "Total Purity Percent"
      expr: SUM(purity_percent)
    - name: "Average Purity Percent"
      expr: AVG(purity_percent)
    - name: "Total Storage Temperature Max C"
      expr: SUM(storage_temperature_max_c)
    - name: "Average Storage Temperature Max C"
      expr: AVG(storage_temperature_max_c)
    - name: "Total Storage Temperature Min C"
      expr: SUM(storage_temperature_min_c)
    - name: "Average Storage Temperature Min C"
      expr: AVG(storage_temperature_min_c)
    - name: "Total Us Fda Maximum Concentration Percent"
      expr: SUM(us_fda_maximum_concentration_percent)
    - name: "Average Us Fda Maximum Concentration Percent"
      expr: AVG(us_fda_maximum_concentration_percent)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_rd_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rd Project business metrics"
  source: "`vibe_consumer_goods_v1`.`research`.`rd_project`"
  dimensions:
    - name: "Actual Launch Date"
      expr: actual_launch_date
    - name: "Business Opportunity Context"
      expr: business_opportunity_context
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Competitive Benchmark"
      expr: competitive_benchmark
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Current Milestone"
      expr: current_milestone
    - name: "Desired Benefits"
      expr: desired_benefits
    - name: "Key Performance Indicators"
      expr: key_performance_indicators
    - name: "Lessons Learned"
      expr: lessons_learned
    - name: "Milestone Due Date"
      expr: milestone_due_date
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Patent Filing Status"
      expr: patent_filing_status
    - name: "Patent Number"
      expr: patent_number
    - name: "Project Code"
      expr: project_code
    - name: "Project Completion Date"
      expr: project_completion_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rd Project"
      expr: COUNT(DISTINCT rd_project_id)
    - name: "Total Budget Allocated"
      expr: SUM(budget_allocated)
    - name: "Average Budget Allocated"
      expr: AVG(budget_allocated)
    - name: "Total Budget Spent"
      expr: SUM(budget_spent)
    - name: "Average Budget Spent"
      expr: AVG(budget_spent)
    - name: "Total Strategic Fit Rationale"
      expr: SUM(strategic_fit_rationale)
    - name: "Average Strategic Fit Rationale"
      expr: AVG(strategic_fit_rationale)
    - name: "Total Strategic Priority Tier"
      expr: SUM(strategic_priority_tier)
    - name: "Average Strategic Priority Tier"
      expr: AVG(strategic_priority_tier)
    - name: "Total Sustainability Score"
      expr: SUM(sustainability_score)
    - name: "Average Sustainability Score"
      expr: AVG(sustainability_score)
    - name: "Total Target Cogs"
      expr: SUM(target_cogs)
    - name: "Average Target Cogs"
      expr: AVG(target_cogs)
    - name: "Total Target Rsp"
      expr: SUM(target_rsp)
    - name: "Average Target Rsp"
      expr: AVG(target_rsp)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_regulatory_dossier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory Dossier business metrics"
  source: "`vibe_consumer_goods_v1`.`research`.`regulatory_dossier`"
  dimensions:
    - name: "Actual Approval Date"
      expr: actual_approval_date
    - name: "Actual Submission Date"
      expr: actual_submission_date
    - name: "Additional Information Due Date"
      expr: additional_information_due_date
    - name: "Additional Information Requested"
      expr: additional_information_requested
    - name: "Allergen Declaration Complete"
      expr: allergen_declaration_complete
    - name: "Animal Testing Statement"
      expr: animal_testing_statement
    - name: "Authority Reference Number"
      expr: authority_reference_number
    - name: "Claim Substantiation Status"
      expr: claim_substantiation_status
    - name: "Cmr Substance Present"
      expr: cmr_substance_present
    - name: "Cpnp Reference Number"
      expr: cpnp_reference_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dossier Reference Number"
      expr: dossier_reference_number
    - name: "Dossier Status"
      expr: dossier_status
    - name: "Dossier Type"
      expr: dossier_type
    - name: "Dossier Version"
      expr: dossier_version
    - name: "Expected Approval Date"
      expr: expected_approval_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Regulatory Dossier"
      expr: COUNT(DISTINCT regulatory_dossier_id)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_research_formulation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Research Formulation business metrics"
  source: "`vibe_consumer_goods_v1`.`research`.`research_formulation`"
  dimensions:
    - name: "Approved Date"
      expr: approved_date
    - name: "Claim Support Required"
      expr: claim_support_required
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cruelty Free Flag"
      expr: cruelty_free_flag
    - name: "Development Status"
      expr: development_status
    - name: "Discontinued Date"
      expr: discontinued_date
    - name: "Formulation Code"
      expr: formulation_code
    - name: "Formulation Description"
      expr: formulation_description
    - name: "Formulation Name"
      expr: formulation_name
    - name: "Formulation Type"
      expr: formulation_type
    - name: "Fragrance Type"
      expr: fragrance_type
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Microbiological Challenge Test Passed"
      expr: microbiological_challenge_test_passed
    - name: "Mixing Time Minutes"
      expr: mixing_time_minutes
    - name: "Patent Filed Flag"
      expr: patent_filed_flag
    - name: "Patent Number"
      expr: patent_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Research Formulation"
      expr: COUNT(DISTINCT research_formulation_id)
    - name: "Total Allergen Declaration"
      expr: SUM(allergen_declaration)
    - name: "Average Allergen Declaration"
      expr: AVG(allergen_declaration)
    - name: "Total Batch Size Kg"
      expr: SUM(batch_size_kg)
    - name: "Average Batch Size Kg"
      expr: AVG(batch_size_kg)
    - name: "Total Consumer Test Score"
      expr: SUM(consumer_test_score)
    - name: "Average Consumer Test Score"
      expr: AVG(consumer_test_score)
    - name: "Total Cooling Rate Celsius Per Min"
      expr: SUM(cooling_rate_celsius_per_min)
    - name: "Average Cooling Rate Celsius Per Min"
      expr: AVG(cooling_rate_celsius_per_min)
    - name: "Total Cost Currency Code"
      expr: SUM(cost_currency_code)
    - name: "Average Cost Currency Code"
      expr: AVG(cost_currency_code)
    - name: "Total Cost Target Per Unit"
      expr: SUM(cost_target_per_unit)
    - name: "Average Cost Target Per Unit"
      expr: AVG(cost_target_per_unit)
    - name: "Total Mixing Temperature Celsius"
      expr: SUM(mixing_temperature_celsius)
    - name: "Average Mixing Temperature Celsius"
      expr: AVG(mixing_temperature_celsius)
    - name: "Total Natural Content Percentage"
      expr: SUM(natural_content_percentage)
    - name: "Average Natural Content Percentage"
      expr: AVG(natural_content_percentage)
    - name: "Total Sensory Evaluation Score"
      expr: SUM(sensory_evaluation_score)
    - name: "Average Sensory Evaluation Score"
      expr: AVG(sensory_evaluation_score)
    - name: "Total Sustainability Score"
      expr: SUM(sustainability_score)
    - name: "Average Sustainability Score"
      expr: AVG(sustainability_score)
    - name: "Total Target Ph Max"
      expr: SUM(target_ph_max)
    - name: "Average Target Ph Max"
      expr: AVG(target_ph_max)
    - name: "Total Target Ph Min"
      expr: SUM(target_ph_min)
    - name: "Average Target Ph Min"
      expr: AVG(target_ph_min)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_research_formulation_ingredient`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Research Formulation Ingredient business metrics"
  source: "`vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient`"
  dimensions:
    - name: "Addition Order"
      expr: addition_order
    - name: "Allergen Flag"
      expr: allergen_flag
    - name: "Approval Date"
      expr: approval_date
    - name: "Asean Restricted Flag"
      expr: asean_restricted_flag
    - name: "Cas Number"
      expr: cas_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Einecs Number"
      expr: einecs_number
    - name: "Eu Restricted Flag"
      expr: eu_restricted_flag
    - name: "Function Class"
      expr: function_class
    - name: "Inci Name"
      expr: inci_name
    - name: "Inclusion Basis"
      expr: inclusion_basis
    - name: "Ingredient Sequence Number"
      expr: ingredient_sequence_number
    - name: "Ingredient Status"
      expr: ingredient_status
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Natural Origin Flag"
      expr: natural_origin_flag
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Research Formulation Ingredient"
      expr: COUNT(DISTINCT research_formulation_ingredient_id)
    - name: "Total Asean Maximum Concentration Percent"
      expr: SUM(asean_maximum_concentration_percent)
    - name: "Average Asean Maximum Concentration Percent"
      expr: AVG(asean_maximum_concentration_percent)
    - name: "Total Cost Currency Code"
      expr: SUM(cost_currency_code)
    - name: "Average Cost Currency Code"
      expr: AVG(cost_currency_code)
    - name: "Total Cost Per Kg"
      expr: SUM(cost_per_kg)
    - name: "Average Cost Per Kg"
      expr: AVG(cost_per_kg)
    - name: "Total Eu Maximum Concentration Percent"
      expr: SUM(eu_maximum_concentration_percent)
    - name: "Average Eu Maximum Concentration Percent"
      expr: AVG(eu_maximum_concentration_percent)
    - name: "Total Maximum Concentration Percent"
      expr: SUM(maximum_concentration_percent)
    - name: "Average Maximum Concentration Percent"
      expr: AVG(maximum_concentration_percent)
    - name: "Total Minimum Concentration Percent"
      expr: SUM(minimum_concentration_percent)
    - name: "Average Minimum Concentration Percent"
      expr: AVG(minimum_concentration_percent)
    - name: "Total Target Concentration Percent"
      expr: SUM(target_concentration_percent)
    - name: "Average Target Concentration Percent"
      expr: AVG(target_concentration_percent)
    - name: "Total Us Fda Maximum Concentration Percent"
      expr: SUM(us_fda_maximum_concentration_percent)
    - name: "Average Us Fda Maximum Concentration Percent"
      expr: AVG(us_fda_maximum_concentration_percent)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_research_packaging_spec`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Research Packaging Spec business metrics"
  source: "`vibe_consumer_goods_v1`.`research`.`research_packaging_spec`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Barrier Properties"
      expr: barrier_properties
    - name: "Child Resistant Certified"
      expr: child_resistant_certified
    - name: "Closure Type"
      expr: closure_type
    - name: "Color Specification"
      expr: color_specification
    - name: "Compatibility Test Date"
      expr: compatibility_test_date
    - name: "Compatibility Test Result"
      expr: compatibility_test_result
    - name: "Component Type"
      expr: component_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Eu Reach Compliant"
      expr: eu_reach_compliant
    - name: "Fda Food Contact Approved"
      expr: fda_food_contact_approved
    - name: "Formulation Compatibility Status"
      expr: formulation_compatibility_status
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Material Grade"
      expr: material_grade
    - name: "Material Type"
      expr: material_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Research Packaging Spec"
      expr: COUNT(DISTINCT research_packaging_spec_id)
    - name: "Total Capacity Ml"
      expr: SUM(capacity_ml)
    - name: "Average Capacity Ml"
      expr: AVG(capacity_ml)
    - name: "Total Component Height Mm"
      expr: SUM(component_height_mm)
    - name: "Average Component Height Mm"
      expr: AVG(component_height_mm)
    - name: "Total Component Length Mm"
      expr: SUM(component_length_mm)
    - name: "Average Component Length Mm"
      expr: AVG(component_length_mm)
    - name: "Total Component Weight Grams"
      expr: SUM(component_weight_grams)
    - name: "Average Component Weight Grams"
      expr: AVG(component_weight_grams)
    - name: "Total Component Width Mm"
      expr: SUM(component_width_mm)
    - name: "Average Component Width Mm"
      expr: AVG(component_width_mm)
    - name: "Total Cost Currency Code"
      expr: SUM(cost_currency_code)
    - name: "Average Cost Currency Code"
      expr: AVG(cost_currency_code)
    - name: "Total Cost Per Unit"
      expr: SUM(cost_per_unit)
    - name: "Average Cost Per Unit"
      expr: AVG(cost_per_unit)
    - name: "Total Decoration Method"
      expr: SUM(decoration_method)
    - name: "Average Decoration Method"
      expr: AVG(decoration_method)
    - name: "Total Recycled Content Percentage"
      expr: SUM(recycled_content_percentage)
    - name: "Average Recycled Content Percentage"
      expr: AVG(recycled_content_percentage)
    - name: "Total Sustainability Score"
      expr: SUM(sustainability_score)
    - name: "Average Sustainability Score"
      expr: AVG(sustainability_score)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_research_sample`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Research Sample business metrics"
  source: "`vibe_consumer_goods_v1`.`research`.`research_sample`"
  dimensions:
    - name: "Batch Number"
      expr: batch_number
    - name: "Research Sample Code"
      expr: research_sample_code
    - name: "Collected By"
      expr: collected_by
    - name: "Collection Location"
      expr: collection_location
    - name: "Collection Timestamp"
      expr: collection_timestamp
    - name: "Compliance Flag"
      expr: compliance_flag
    - name: "Research Sample Description"
      expr: research_sample_description
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Hazard Classification"
      expr: hazard_classification
    - name: "Is Control"
      expr: is_control
    - name: "Material Category"
      expr: material_category
    - name: "Research Sample Name"
      expr: research_sample_name
    - name: "Notes"
      expr: notes
    - name: "Quality Status"
      expr: quality_status
    - name: "Record Audit Created"
      expr: record_audit_created
    - name: "Record Audit Updated"
      expr: record_audit_updated
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Research Sample"
      expr: COUNT(DISTINCT research_sample_id)
    - name: "Total Concentration Percent"
      expr: SUM(concentration_percent)
    - name: "Average Concentration Percent"
      expr: AVG(concentration_percent)
    - name: "Total Storage Temperature C"
      expr: SUM(storage_temperature_c)
    - name: "Average Storage Temperature C"
      expr: AVG(storage_temperature_c)
    - name: "Total Volume Ml"
      expr: SUM(volume_ml)
    - name: "Average Volume Ml"
      expr: AVG(volume_ml)
    - name: "Total Weight G"
      expr: SUM(weight_g)
    - name: "Average Weight G"
      expr: AVG(weight_g)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_research_stability_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Research Stability Study business metrics"
  source: "`vibe_consumer_goods_v1`.`research`.`research_stability_study`"
  dimensions:
    - name: "Approved By"
      expr: approved_by
    - name: "Batch Number"
      expr: batch_number
    - name: "Chamber Code"
      expr: chamber_code
    - name: "Color Stability Method"
      expr: color_stability_method
    - name: "Comments"
      expr: comments
    - name: "Container Closure System"
      expr: container_closure_system
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source System"
      expr: data_source_system
    - name: "Deviation Count"
      expr: deviation_count
    - name: "Gmp Compliant Flag"
      expr: gmp_compliant_flag
    - name: "Ich Condition"
      expr: ich_condition
    - name: "Inci Ingredient List"
      expr: inci_ingredient_list
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Microbial Limit Cfu Per G"
      expr: microbial_limit_cfu_per_g
    - name: "Overall Stability Conclusion"
      expr: overall_stability_conclusion
    - name: "Ph Target Range"
      expr: ph_target_range
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Research Stability Study"
      expr: COUNT(DISTINCT research_stability_study_id)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_respondent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Respondent business metrics"
  source: "`vibe_consumer_goods_v1`.`research`.`respondent`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "City"
      expr: city
    - name: "Consent Given Date"
      expr: consent_given_date
    - name: "Consent Revoked Flag"
      expr: consent_revoked_flag
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Date Of Birth"
      expr: date_of_birth
    - name: "Device Type"
      expr: device_type
    - name: "Education Level"
      expr: education_level
    - name: "Email"
      expr: email
    - name: "Ethnicity"
      expr: ethnicity
    - name: "External Code"
      expr: external_code
    - name: "Full Name"
      expr: full_name
    - name: "Gender"
      expr: gender
    - name: "Household Size"
      expr: household_size
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Respondent"
      expr: COUNT(DISTINCT respondent_id)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_safety_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety Assessment business metrics"
  source: "`vibe_consumer_goods_v1`.`research`.`safety_assessment`"
  dimensions:
    - name: "Application Frequency"
      expr: application_frequency
    - name: "Application Site"
      expr: application_site
    - name: "Approval Date"
      expr: approval_date
    - name: "Assessment Code"
      expr: assessment_code
    - name: "Assessment Date"
      expr: assessment_date
    - name: "Assessment Start Date"
      expr: assessment_start_date
    - name: "Assessment Status"
      expr: assessment_status
    - name: "Assessment Type"
      expr: assessment_type
    - name: "Assessor Name"
      expr: assessor_name
    - name: "Assessor Qualification"
      expr: assessor_qualification
    - name: "Conditions Of Use"
      expr: conditions_of_use
    - name: "Contraindications"
      expr: contraindications
    - name: "Cpnp Notification Required"
      expr: cpnp_notification_required
    - name: "Cpnp Reference Number"
      expr: cpnp_reference_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Document Location"
      expr: document_location
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Safety Assessment"
      expr: COUNT(DISTINCT safety_assessment_id)
    - name: "Total Allergen Declaration"
      expr: SUM(allergen_declaration)
    - name: "Average Allergen Declaration"
      expr: AVG(allergen_declaration)
    - name: "Total Assessor Registration Number"
      expr: SUM(assessor_registration_number)
    - name: "Average Assessor Registration Number"
      expr: AVG(assessor_registration_number)
    - name: "Total Exposure Duration"
      expr: SUM(exposure_duration)
    - name: "Average Exposure Duration"
      expr: AVG(exposure_duration)
    - name: "Total Margin Of Safety"
      expr: SUM(margin_of_safety)
    - name: "Average Margin Of Safety"
      expr: AVG(margin_of_safety)
    - name: "Total Noael Value"
      expr: SUM(noael_value)
    - name: "Average Noael Value"
      expr: AVG(noael_value)
    - name: "Total Systemic Exposure Estimate"
      expr: SUM(systemic_exposure_estimate)
    - name: "Average Systemic Exposure Estimate"
      expr: AVG(systemic_exposure_estimate)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_scale_up_trial`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Scale Up Trial business metrics"
  source: "`vibe_consumer_goods_v1`.`research`.`scale_up_trial`"
  dimensions:
    - name: "Appearance Assessment"
      expr: appearance_assessment
    - name: "Color Measurement"
      expr: color_measurement
    - name: "Corrective Action Taken"
      expr: corrective_action_taken
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deviation Description"
      expr: deviation_description
    - name: "Deviation Impact Assessment"
      expr: deviation_impact_assessment
    - name: "Deviation Observed Flag"
      expr: deviation_observed_flag
    - name: "In Process Test Results"
      expr: in_process_test_results
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lessons Learned"
      expr: lessons_learned
    - name: "Manufacturing Readiness Level"
      expr: manufacturing_readiness_level
    - name: "Manufacturing Sign Off Date"
      expr: manufacturing_sign_off_date
    - name: "Manufacturing Site Code"
      expr: manufacturing_site_code
    - name: "Mixing Speed Rpm"
      expr: mixing_speed_rpm
    - name: "Mixing Time Minutes"
      expr: mixing_time_minutes
    - name: "Next Steps"
      expr: next_steps
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Scale Up Trial"
      expr: COUNT(DISTINCT scale_up_trial_id)
    - name: "Total Actual Output Kg"
      expr: SUM(actual_output_kg)
    - name: "Average Actual Output Kg"
      expr: AVG(actual_output_kg)
    - name: "Total Batch Size Kg"
      expr: SUM(batch_size_kg)
    - name: "Average Batch Size Kg"
      expr: AVG(batch_size_kg)
    - name: "Total Cooling Rate Celsius Per Min"
      expr: SUM(cooling_rate_celsius_per_min)
    - name: "Average Cooling Rate Celsius Per Min"
      expr: AVG(cooling_rate_celsius_per_min)
    - name: "Total Cost Currency Code"
      expr: SUM(cost_currency_code)
    - name: "Average Cost Currency Code"
      expr: AVG(cost_currency_code)
    - name: "Total Equipment Configuration"
      expr: SUM(equipment_configuration)
    - name: "Average Equipment Configuration"
      expr: AVG(equipment_configuration)
    - name: "Total Heating Rate Celsius Per Min"
      expr: SUM(heating_rate_celsius_per_min)
    - name: "Average Heating Rate Celsius Per Min"
      expr: AVG(heating_rate_celsius_per_min)
    - name: "Total Pass Fail Rationale"
      expr: SUM(pass_fail_rationale)
    - name: "Average Pass Fail Rationale"
      expr: AVG(pass_fail_rationale)
    - name: "Total Ph Value"
      expr: SUM(ph_value)
    - name: "Average Ph Value"
      expr: AVG(ph_value)
    - name: "Total Process Temperature Celsius"
      expr: SUM(process_temperature_celsius)
    - name: "Average Process Temperature Celsius"
      expr: AVG(process_temperature_celsius)
    - name: "Total Scale Factor"
      expr: SUM(scale_factor)
    - name: "Average Scale Factor"
      expr: AVG(scale_factor)
    - name: "Total Trial Cost Amount"
      expr: SUM(trial_cost_amount)
    - name: "Average Trial Cost Amount"
      expr: AVG(trial_cost_amount)
    - name: "Total Yield Percentage"
      expr: SUM(yield_percentage)
    - name: "Average Yield Percentage"
      expr: AVG(yield_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_sensory_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sensory Evaluation business metrics"
  source: "`vibe_consumer_goods_v1`.`research`.`sensory_evaluation`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Attributes Assessed"
      expr: attributes_assessed
    - name: "Benchmark Product Code"
      expr: benchmark_product_code
    - name: "Blinding Method"
      expr: blinding_method
    - name: "Completion Timestamp"
      expr: completion_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Evaluation Code"
      expr: evaluation_code
    - name: "Evaluation Date"
      expr: evaluation_date
    - name: "Evaluation Methodology"
      expr: evaluation_methodology
    - name: "Evaluation Notes"
      expr: evaluation_notes
    - name: "Evaluation Status"
      expr: evaluation_status
    - name: "Formulation Version"
      expr: formulation_version
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Panel Type"
      expr: panel_type
    - name: "Panelist Count"
      expr: panelist_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sensory Evaluation"
      expr: COUNT(DISTINCT sensory_evaluation_id)
    - name: "Total After Feel Score"
      expr: SUM(after_feel_score)
    - name: "Average After Feel Score"
      expr: AVG(after_feel_score)
    - name: "Total Color Score"
      expr: SUM(color_score)
    - name: "Average Color Score"
      expr: AVG(color_score)
    - name: "Total Confidence Level"
      expr: SUM(confidence_level)
    - name: "Average Confidence Level"
      expr: AVG(confidence_level)
    - name: "Total Data Quality Score"
      expr: SUM(data_quality_score)
    - name: "Average Data Quality Score"
      expr: AVG(data_quality_score)
    - name: "Total Odor Score"
      expr: SUM(odor_score)
    - name: "Average Odor Score"
      expr: AVG(odor_score)
    - name: "Total Overall Liking Score"
      expr: SUM(overall_liking_score)
    - name: "Average Overall Liking Score"
      expr: AVG(overall_liking_score)
    - name: "Total Purchase Intent Score"
      expr: SUM(purchase_intent_score)
    - name: "Average Purchase Intent Score"
      expr: AVG(purchase_intent_score)
    - name: "Total Rinse Off Feel Score"
      expr: SUM(rinse_off_feel_score)
    - name: "Average Rinse Off Feel Score"
      expr: AVG(rinse_off_feel_score)
    - name: "Total Spreadability Score"
      expr: SUM(spreadability_score)
    - name: "Average Spreadability Score"
      expr: AVG(spreadability_score)
    - name: "Total Texture Score"
      expr: SUM(texture_score)
    - name: "Average Texture Score"
      expr: AVG(texture_score)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_stability_timepoint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stability Timepoint business metrics"
  source: "`vibe_consumer_goods_v1`.`research`.`stability_timepoint`"
  dimensions:
    - name: "Analyst Name"
      expr: analyst_name
    - name: "Batch Number"
      expr: batch_number
    - name: "Comments"
      expr: comments
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Integrity Hash"
      expr: data_integrity_hash
    - name: "Deviation Flag"
      expr: deviation_flag
    - name: "Deviation Reference Number"
      expr: deviation_reference_number
    - name: "Instrument Code"
      expr: instrument_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Measurement Date"
      expr: measurement_date
    - name: "Pass Fail Status"
      expr: pass_fail_status
    - name: "Record Status"
      expr: record_status
    - name: "Regulatory Reportable Flag"
      expr: regulatory_reportable_flag
    - name: "Retest Flag"
      expr: retest_flag
    - name: "Retest Reason"
      expr: retest_reason
    - name: "Review Date"
      expr: review_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Stability Timepoint"
      expr: COUNT(DISTINCT stability_timepoint_id)
    - name: "Total Measured Value"
      expr: SUM(measured_value)
    - name: "Average Measured Value"
      expr: AVG(measured_value)
    - name: "Total Storage Humidity Pct"
      expr: SUM(storage_humidity_pct)
    - name: "Average Storage Humidity Pct"
      expr: AVG(storage_humidity_pct)
    - name: "Total Storage Temperature C"
      expr: SUM(storage_temperature_c)
    - name: "Average Storage Temperature C"
      expr: AVG(storage_temperature_c)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_stage_gate_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stage Gate Milestone business metrics"
  source: "`vibe_consumer_goods_v1`.`research`.`stage_gate_milestone`"
  dimensions:
    - name: "Action Items"
      expr: action_items
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Delay Reason"
      expr: delay_reason
    - name: "Deliverables Checklist Status"
      expr: deliverables_checklist_status
    - name: "Gate Attendees"
      expr: gate_attendees
    - name: "Gate Criteria Met Count"
      expr: gate_criteria_met_count
    - name: "Gate Criteria Total Count"
      expr: gate_criteria_total_count
    - name: "Gate Decision"
      expr: gate_decision
    - name: "Gate Duration Days"
      expr: gate_duration_days
    - name: "Gate Name"
      expr: gate_name
    - name: "Gate Number"
      expr: gate_number
    - name: "Gate Status"
      expr: gate_status
    - name: "Investment Currency Code"
      expr: investment_currency_code
    - name: "Is Milestone Delayed"
      expr: is_milestone_delayed
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Next Gate Target Date"
      expr: next_gate_target_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Stage Gate Milestone"
      expr: COUNT(DISTINCT stage_gate_milestone_id)
    - name: "Total Consumer Acceptance Score"
      expr: SUM(consumer_acceptance_score)
    - name: "Average Consumer Acceptance Score"
      expr: AVG(consumer_acceptance_score)
    - name: "Total Decision Rationale"
      expr: SUM(decision_rationale)
    - name: "Average Decision Rationale"
      expr: AVG(decision_rationale)
    - name: "Total Deliverables Completion Percentage"
      expr: SUM(deliverables_completion_percentage)
    - name: "Average Deliverables Completion Percentage"
      expr: AVG(deliverables_completion_percentage)
    - name: "Total Investment Approved Amount"
      expr: SUM(investment_approved_amount)
    - name: "Average Investment Approved Amount"
      expr: AVG(investment_approved_amount)
    - name: "Total Market Attractiveness Score"
      expr: SUM(market_attractiveness_score)
    - name: "Average Market Attractiveness Score"
      expr: AVG(market_attractiveness_score)
    - name: "Total Npv Estimate"
      expr: SUM(npv_estimate)
    - name: "Average Npv Estimate"
      expr: AVG(npv_estimate)
    - name: "Total Risk Assessment Score"
      expr: SUM(risk_assessment_score)
    - name: "Average Risk Assessment Score"
      expr: AVG(risk_assessment_score)
    - name: "Total Roi Estimate Percentage"
      expr: SUM(roi_estimate_percentage)
    - name: "Average Roi Estimate Percentage"
      expr: AVG(roi_estimate_percentage)
    - name: "Total Sustainability Score"
      expr: SUM(sustainability_score)
    - name: "Average Sustainability Score"
      expr: AVG(sustainability_score)
    - name: "Total Technical Feasibility Score"
      expr: SUM(technical_feasibility_score)
    - name: "Average Technical Feasibility Score"
      expr: AVG(technical_feasibility_score)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_study_protocol`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Study Protocol business metrics"
  source: "`vibe_consumer_goods_v1`.`research`.`study_protocol`"
  dimensions:
    - name: "Amendment Date"
      expr: amendment_date
    - name: "Amendment Number"
      expr: amendment_number
    - name: "Blinding"
      expr: blinding
    - name: "Creation Timestamp"
      expr: creation_timestamp
    - name: "Data Retention Period"
      expr: data_retention_period
    - name: "Data Sharing Policy"
      expr: data_sharing_policy
    - name: "Study Protocol Description"
      expr: study_protocol_description
    - name: "Design Type"
      expr: design_type
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Ethics Approval Date"
      expr: ethics_approval_date
    - name: "Ethics Approval Number"
      expr: ethics_approval_number
    - name: "Exclusion Criteria"
      expr: exclusion_criteria
    - name: "Inclusion Criteria"
      expr: inclusion_criteria
    - name: "Indication"
      expr: indication
    - name: "Is Confidential"
      expr: is_confidential
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Study Protocol"
      expr: COUNT(DISTINCT study_protocol_id)
    - name: "Total Sample Size"
      expr: SUM(sample_size)
    - name: "Average Sample Size"
      expr: AVG(sample_size)
$$;