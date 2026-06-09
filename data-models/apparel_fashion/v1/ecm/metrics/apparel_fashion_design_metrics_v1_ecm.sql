-- Metric views for domain: design | Business: Apparel Fashion | Version: 1 | Generated on: 2026-05-05 15:54:11

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`design_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset business metrics"
  source: "`apparel_fashion_ecm`.`design`.`asset`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Archived Timestamp"
      expr: archived_timestamp
    - name: "Asset Code"
      expr: asset_code
    - name: "Asset Description"
      expr: asset_description
    - name: "Asset Name"
      expr: asset_name
    - name: "Asset Status"
      expr: asset_status
    - name: "Asset Type"
      expr: asset_type
    - name: "Checksum Hash"
      expr: checksum_hash
    - name: "Color Palette Hex Codes"
      expr: color_palette_hex_codes
    - name: "Copyright Attribution"
      expr: copyright_attribution
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Fabric Reference Code"
      expr: fabric_reference_code
    - name: "File Format"
      expr: file_format
    - name: "Gender Target"
      expr: gender_target
    - name: "Inspiration Source"
      expr: inspiration_source
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Asset"
      expr: COUNT(DISTINCT asset_id)
    - name: "Total File Size Bytes"
      expr: SUM(file_size_bytes)
    - name: "Average File Size Bytes"
      expr: AVG(file_size_bytes)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`design_brief`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brief business metrics"
  source: "`apparel_fashion_ecm`.`design`.`brief`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Brief Code"
      expr: brief_code
    - name: "Brief Status"
      expr: brief_status
    - name: "Collaboration Notes"
      expr: collaboration_notes
    - name: "Commercial Objectives"
      expr: commercial_objectives
    - name: "Competitive Benchmarks"
      expr: competitive_benchmarks
    - name: "Completed Date"
      expr: completed_date
    - name: "Concept Submission Deadline"
      expr: concept_submission_deadline
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Delivery Milestone Date"
      expr: delivery_milestone_date
    - name: "Design Direction"
      expr: design_direction
    - name: "Design Team Size"
      expr: design_team_size
    - name: "Distribution Channel Target"
      expr: distribution_channel_target
    - name: "Gender Target"
      expr: gender_target
    - name: "Geographic Market Focus"
      expr: geographic_market_focus
    - name: "Is Confidential"
      expr: is_confidential
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Brief"
      expr: COUNT(DISTINCT brief_id)
    - name: "Total Brand Alignment Score"
      expr: SUM(brand_alignment_score)
    - name: "Average Brand Alignment Score"
      expr: AVG(brand_alignment_score)
    - name: "Total Budget Allocated"
      expr: SUM(budget_allocated)
    - name: "Average Budget Allocated"
      expr: AVG(budget_allocated)
    - name: "Total Target Margin Percent"
      expr: SUM(target_margin_percent)
    - name: "Average Target Margin Percent"
      expr: AVG(target_margin_percent)
    - name: "Total Target Price Point"
      expr: SUM(target_price_point)
    - name: "Average Target Price Point"
      expr: AVG(target_price_point)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`design_cad_file`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cad File business metrics"
  source: "`apparel_fashion_ecm`.`design`.`cad_file`"
  dimensions:
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Archived Timestamp"
      expr: archived_timestamp
    - name: "Checksum Hash"
      expr: checksum_hash
    - name: "Collaboration Notes"
      expr: collaboration_notes
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Design Complexity"
      expr: design_complexity
    - name: "Design Phase"
      expr: design_phase
    - name: "File Format"
      expr: file_format
    - name: "File Name"
      expr: file_name
    - name: "File Status"
      expr: file_status
    - name: "Garment Category"
      expr: garment_category
    - name: "Is 3d Simulation"
      expr: is_3d_simulation
    - name: "Is Production Ready"
      expr: is_production_ready
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Rejection Reason"
      expr: rejection_reason
    - name: "Season Code"
      expr: season_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cad File"
      expr: COUNT(DISTINCT cad_file_id)
    - name: "Total File Size Bytes"
      expr: SUM(file_size_bytes)
    - name: "Average File Size Bytes"
      expr: AVG(file_size_bytes)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`design_calendar`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Calendar business metrics"
  source: "`apparel_fashion_ecm`.`design`.`calendar`"
  dimensions:
    - name: "Actual Sku Count"
      expr: actual_sku_count
    - name: "Approval Date"
      expr: approval_date
    - name: "Calendar Code"
      expr: calendar_code
    - name: "Calendar Name"
      expr: calendar_name
    - name: "Calendar Status"
      expr: calendar_status
    - name: "Concept Kickoff Actual Date"
      expr: concept_kickoff_actual_date
    - name: "Concept Kickoff Planned Date"
      expr: concept_kickoff_planned_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Critical Path Flag"
      expr: critical_path_flag
    - name: "Delay Days"
      expr: delay_days
    - name: "End Date"
      expr: end_date
    - name: "Gender Target"
      expr: gender_target
    - name: "Is Active"
      expr: is_active
    - name: "Line Review Actual Date"
      expr: line_review_actual_date
    - name: "Line Review Planned Date"
      expr: line_review_planned_date
    - name: "Modified Timestamp"
      expr: modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Calendar"
      expr: COUNT(DISTINCT calendar_id)
    - name: "Total Completion Percentage"
      expr: SUM(completion_percentage)
    - name: "Average Completion Percentage"
      expr: AVG(completion_percentage)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`design_collaboration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Collaboration business metrics"
  source: "`apparel_fashion_ecm`.`design`.`collaboration`"
  dimensions:
    - name: "Actual Launch Date"
      expr: actual_launch_date
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Collaboration Code"
      expr: collaboration_code
    - name: "Collaboration Name"
      expr: collaboration_name
    - name: "Collaboration Status"
      expr: collaboration_status
    - name: "Collaboration Type"
      expr: collaboration_type
    - name: "Contract Document Url"
      expr: contract_document_url
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Contracted Deliverables"
      expr: contracted_deliverables
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Design Ownership Terms"
      expr: design_ownership_terms
    - name: "Distribution Channels"
      expr: distribution_channels
    - name: "Estimated Sku Count"
      expr: estimated_sku_count
    - name: "Exclusivity Terms"
      expr: exclusivity_terms
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Collaboration"
      expr: COUNT(DISTINCT collaboration_id)
    - name: "Total Advance Payment Amount"
      expr: SUM(advance_payment_amount)
    - name: "Average Advance Payment Amount"
      expr: AVG(advance_payment_amount)
    - name: "Total Flat Fee Amount"
      expr: SUM(flat_fee_amount)
    - name: "Average Flat Fee Amount"
      expr: AVG(flat_fee_amount)
    - name: "Total Minimum Guarantee Amount"
      expr: SUM(minimum_guarantee_amount)
    - name: "Average Minimum Guarantee Amount"
      expr: AVG(minimum_guarantee_amount)
    - name: "Total Royalty Rate Percent"
      expr: SUM(royalty_rate_percent)
    - name: "Average Royalty Rate Percent"
      expr: AVG(royalty_rate_percent)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`design_color_palette`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Color Palette business metrics"
  source: "`apparel_fashion_ecm`.`design`.`color_palette`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Collaboration Notes"
      expr: collaboration_notes
    - name: "Color Story Narrative"
      expr: color_story_narrative
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Design Team"
      expr: design_team
    - name: "Digital File Path"
      expr: digital_file_path
    - name: "Gender Target"
      expr: gender_target
    - name: "Geographic Market Focus"
      expr: geographic_market_focus
    - name: "Hex Codes List"
      expr: hex_codes_list
    - name: "Is Active"
      expr: is_active
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Ncs Codes List"
      expr: ncs_codes_list
    - name: "Number Of Colors"
      expr: number_of_colors
    - name: "Palette Category"
      expr: palette_category
    - name: "Palette Code"
      expr: palette_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Color Palette"
      expr: COUNT(DISTINCT color_palette_id)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`design_colorway_development`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Colorway Development business metrics"
  source: "`apparel_fashion_ecm`.`design`.`colorway_development`"
  dimensions:
    - name: "Body Color Hex"
      expr: body_color_hex
    - name: "Body Color Ncs"
      expr: body_color_ncs
    - name: "Body Color Pantone"
      expr: body_color_pantone
    - name: "Body Color Ral"
      expr: body_color_ral
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Cancelled Date"
      expr: cancelled_date
    - name: "Color Matching Tolerance"
      expr: color_matching_tolerance
    - name: "Color Story Theme"
      expr: color_story_theme
    - name: "Colorfastness Requirement"
      expr: colorfastness_requirement
    - name: "Colorway Code"
      expr: colorway_code
    - name: "Colorway Name"
      expr: colorway_name
    - name: "Confirmed Date"
      expr: confirmed_date
    - name: "Contrast Color Hex"
      expr: contrast_color_hex
    - name: "Contrast Color Pantone"
      expr: contrast_color_pantone
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Designer Notes"
      expr: designer_notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Colorway Development"
      expr: COUNT(DISTINCT colorway_development_id)
    - name: "Total Target Cost Per Unit"
      expr: SUM(target_cost_per_unit)
    - name: "Average Target Cost Per Unit"
      expr: AVG(target_cost_per_unit)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`design_concept`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Concept business metrics"
  source: "`apparel_fashion_ecm`.`design`.`concept`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Collaboration Notes"
      expr: collaboration_notes
    - name: "Color Palette Description"
      expr: color_palette_description
    - name: "Concept Code"
      expr: concept_code
    - name: "Concept Name"
      expr: concept_name
    - name: "Concept Status"
      expr: concept_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Design Direction"
      expr: design_direction
    - name: "Estimated Unit Count"
      expr: estimated_unit_count
    - name: "Fabric Direction"
      expr: fabric_direction
    - name: "Gender Target"
      expr: gender_target
    - name: "Inspiration Sources"
      expr: inspiration_sources
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Mood Board Url"
      expr: mood_board_url
    - name: "Mood Keywords"
      expr: mood_keywords
    - name: "Price Tier"
      expr: price_tier
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Concept"
      expr: COUNT(DISTINCT concept_id)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`design_designer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Designer business metrics"
  source: "`apparel_fashion_ecm`.`design`.`designer`"
  dimensions:
    - name: "Assigned Categories"
      expr: assigned_categories
    - name: "Awards Recognition"
      expr: awards_recognition
    - name: "Certifications"
      expr: certifications
    - name: "Collaboration Notes"
      expr: collaboration_notes
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Design Team Assignment"
      expr: design_team_assignment
    - name: "Designer Code"
      expr: designer_code
    - name: "Designer Status"
      expr: designer_status
    - name: "Designer Type"
      expr: designer_type
    - name: "Education Background"
      expr: education_background
    - name: "Email Address"
      expr: email_address
    - name: "Employment Type"
      expr: employment_type
    - name: "Full Name"
      expr: full_name
    - name: "Hire Date"
      expr: hire_date
    - name: "Is Confidential"
      expr: is_confidential
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Designer"
      expr: COUNT(DISTINCT designer_id)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`design_embellishment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Embellishment business metrics"
  source: "`apparel_fashion_ecm`.`design`.`embellishment`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Care Instructions"
      expr: care_instructions
    - name: "Color Specification"
      expr: color_specification
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Digital File Path"
      expr: digital_file_path
    - name: "Embellishment Code"
      expr: embellishment_code
    - name: "Embellishment Name"
      expr: embellishment_name
    - name: "Embellishment Type"
      expr: embellishment_type
    - name: "File Format"
      expr: file_format
    - name: "Ip Ownership"
      expr: ip_ownership
    - name: "Is Active"
      expr: is_active
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "License Agreement Reference"
      expr: license_agreement_reference
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Embellishment"
      expr: COUNT(DISTINCT embellishment_id)
    - name: "Total Height Cm"
      expr: SUM(height_cm)
    - name: "Average Height Cm"
      expr: AVG(height_cm)
    - name: "Total Unit Cost"
      expr: SUM(unit_cost)
    - name: "Average Unit Cost"
      expr: AVG(unit_cost)
    - name: "Total Width Cm"
      expr: SUM(width_cm)
    - name: "Average Width Cm"
      expr: AVG(width_cm)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`design_fabric_swatch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fabric Swatch business metrics"
  source: "`apparel_fashion_ecm`.`design`.`fabric_swatch`"
  dimensions:
    - name: "Adoption Decision"
      expr: adoption_decision
    - name: "Care Instructions"
      expr: care_instructions
    - name: "Collection Name"
      expr: collection_name
    - name: "Color Code"
      expr: color_code
    - name: "Color Name"
      expr: color_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Designer Evaluation Notes"
      expr: designer_evaluation_notes
    - name: "Digital File Path"
      expr: digital_file_path
    - name: "Fabric Finish"
      expr: fabric_finish
    - name: "Fabric Type"
      expr: fabric_type
    - name: "Fiber Composition"
      expr: fiber_composition
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Moq Unit Of Measure"
      expr: moq_unit_of_measure
    - name: "Performance Attributes"
      expr: performance_attributes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fabric Swatch"
      expr: COUNT(DISTINCT fabric_swatch_id)
    - name: "Total Color Hex Value"
      expr: SUM(color_hex_value)
    - name: "Average Color Hex Value"
      expr: AVG(color_hex_value)
    - name: "Total Estimated Cost Per Meter"
      expr: SUM(estimated_cost_per_meter)
    - name: "Average Estimated Cost Per Meter"
      expr: AVG(estimated_cost_per_meter)
    - name: "Total Fabric Weight Gsm"
      expr: SUM(fabric_weight_gsm)
    - name: "Average Fabric Weight Gsm"
      expr: AVG(fabric_weight_gsm)
    - name: "Total Fabric Width Cm"
      expr: SUM(fabric_width_cm)
    - name: "Average Fabric Width Cm"
      expr: AVG(fabric_width_cm)
    - name: "Total Minimum Order Quantity"
      expr: SUM(minimum_order_quantity)
    - name: "Average Minimum Order Quantity"
      expr: AVG(minimum_order_quantity)
    - name: "Total Sustainability Score"
      expr: SUM(sustainability_score)
    - name: "Average Sustainability Score"
      expr: AVG(sustainability_score)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`design_handoff`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Handoff business metrics"
  source: "`apparel_fashion_ecm`.`design`.`handoff`"
  dimensions:
    - name: "Acknowledgment Date"
      expr: acknowledgment_date
    - name: "Approval Date"
      expr: approval_date
    - name: "Bom Draft Included"
      expr: bom_draft_included
    - name: "Bom Draft Version"
      expr: bom_draft_version
    - name: "Cad File Format"
      expr: cad_file_format
    - name: "Cad Files Included"
      expr: cad_files_included
    - name: "Collaboration Platform"
      expr: collaboration_platform
    - name: "Collection Name"
      expr: collection_name
    - name: "Colorway Count"
      expr: colorway_count
    - name: "Colorway Specs Included"
      expr: colorway_specs_included
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Feedback Notes"
      expr: feedback_notes
    - name: "Gender Target"
      expr: gender_target
    - name: "Handoff Date"
      expr: handoff_date
    - name: "Handoff Number"
      expr: handoff_number
    - name: "Handoff Status"
      expr: handoff_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Handoff"
      expr: COUNT(DISTINCT handoff_id)
    - name: "Total Target Price Point"
      expr: SUM(target_price_point)
    - name: "Average Target Price Point"
      expr: AVG(target_price_point)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`design_inspiration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspiration business metrics"
  source: "`apparel_fashion_ecm`.`design`.`inspiration`"
  dimensions:
    - name: "Additional Media Urls"
      expr: additional_media_urls
    - name: "Adoption Status"
      expr: adoption_status
    - name: "Color Palette"
      expr: color_palette
    - name: "Construction Details"
      expr: construction_details
    - name: "Copyright Attribution"
      expr: copyright_attribution
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cultural Influence"
      expr: cultural_influence
    - name: "Design Notes"
      expr: design_notes
    - name: "Designer Brand"
      expr: designer_brand
    - name: "Fabric Elements"
      expr: fabric_elements
    - name: "Gender Target"
      expr: gender_target
    - name: "Geographic Origin"
      expr: geographic_origin
    - name: "Image Reference Url"
      expr: image_reference_url
    - name: "Inspiration Code"
      expr: inspiration_code
    - name: "Inspiration Description"
      expr: inspiration_description
    - name: "Is Active"
      expr: is_active
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Inspiration"
      expr: COUNT(DISTINCT inspiration_id)
    - name: "Total Relevance Score"
      expr: SUM(relevance_score)
    - name: "Average Relevance Score"
      expr: AVG(relevance_score)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`design_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Milestone business metrics"
  source: "`apparel_fashion_ecm`.`design`.`milestone`"
  dimensions:
    - name: "Actual Completion Date"
      expr: actual_completion_date
    - name: "Actual Deliverable Count"
      expr: actual_deliverable_count
    - name: "Approval Date"
      expr: approval_date
    - name: "Baseline Date"
      expr: baseline_date
    - name: "Completion Status"
      expr: completion_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Critical Path Flag"
      expr: critical_path_flag
    - name: "Delay Days"
      expr: delay_days
    - name: "Delay Reason Code"
      expr: delay_reason_code
    - name: "Deliverable Count"
      expr: deliverable_count
    - name: "Deliverable Description"
      expr: deliverable_description
    - name: "Dependency Type"
      expr: dependency_type
    - name: "Forecast Date"
      expr: forecast_date
    - name: "Gate Type"
      expr: gate_type
    - name: "Is Active"
      expr: is_active
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Milestone"
      expr: COUNT(DISTINCT milestone_id)
    - name: "Total Actual Effort Hours"
      expr: SUM(actual_effort_hours)
    - name: "Average Actual Effort Hours"
      expr: AVG(actual_effort_hours)
    - name: "Total Estimated Effort Hours"
      expr: SUM(estimated_effort_hours)
    - name: "Average Estimated Effort Hours"
      expr: AVG(estimated_effort_hours)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`design_mood_board`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mood Board business metrics"
  source: "`apparel_fashion_ecm`.`design`.`mood_board`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved Date"
      expr: approved_date
    - name: "Board Code"
      expr: board_code
    - name: "Brand Alignment"
      expr: brand_alignment
    - name: "Collaboration Notes"
      expr: collaboration_notes
    - name: "Color Story"
      expr: color_story
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Creative Theme"
      expr: creative_theme
    - name: "Cultural References"
      expr: cultural_references
    - name: "Digital File Path"
      expr: digital_file_path
    - name: "Format Type"
      expr: format_type
    - name: "Gender Category"
      expr: gender_category
    - name: "Geographic Market Focus"
      expr: geographic_market_focus
    - name: "Inspiration Source"
      expr: inspiration_source
    - name: "Is Active"
      expr: is_active
    - name: "Is Confidential"
      expr: is_confidential
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Mood Board"
      expr: COUNT(DISTINCT mood_board_id)
    - name: "Total Trend Alignment Score"
      expr: SUM(trend_alignment_score)
    - name: "Average Trend Alignment Score"
      expr: AVG(trend_alignment_score)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`design_mood_board_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mood Board Asset business metrics"
  source: "`apparel_fashion_ecm`.`design`.`mood_board_asset`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Asset Caption"
      expr: asset_caption
    - name: "Asset File Format"
      expr: asset_file_format
    - name: "Asset File Name"
      expr: asset_file_name
    - name: "Asset File Path"
      expr: asset_file_path
    - name: "Asset Sequence Number"
      expr: asset_sequence_number
    - name: "Asset Source Url"
      expr: asset_source_url
    - name: "Asset Status"
      expr: asset_status
    - name: "Asset Tags"
      expr: asset_tags
    - name: "Asset Type"
      expr: asset_type
    - name: "Color Palette Hex Codes"
      expr: color_palette_hex_codes
    - name: "Copyright Attribution"
      expr: copyright_attribution
    - name: "Fabric Reference Code"
      expr: fabric_reference_code
    - name: "Inspiration Source"
      expr: inspiration_source
    - name: "Is Featured"
      expr: is_featured
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Mood Board Asset"
      expr: COUNT(DISTINCT mood_board_asset_id)
    - name: "Total Asset File Size Bytes"
      expr: SUM(asset_file_size_bytes)
    - name: "Average Asset File Size Bytes"
      expr: AVG(asset_file_size_bytes)
    - name: "Total Asset Height"
      expr: SUM(asset_height)
    - name: "Average Asset Height"
      expr: AVG(asset_height)
    - name: "Total Asset Width"
      expr: SUM(asset_width)
    - name: "Average Asset Width"
      expr: AVG(asset_width)
    - name: "Total Position X Coordinate"
      expr: SUM(position_x_coordinate)
    - name: "Average Position X Coordinate"
      expr: AVG(position_x_coordinate)
    - name: "Total Position Y Coordinate"
      expr: SUM(position_y_coordinate)
    - name: "Average Position Y Coordinate"
      expr: AVG(position_y_coordinate)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`design_pattern_block`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pattern Block business metrics"
  source: "`apparel_fashion_ecm`.`design`.`pattern_block`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Block Code"
      expr: block_code
    - name: "Block Description"
      expr: block_description
    - name: "Block Name"
      expr: block_name
    - name: "Block Status"
      expr: block_status
    - name: "Body Measurement Basis"
      expr: body_measurement_basis
    - name: "Fabric Type Recommendation"
      expr: fabric_type_recommendation
    - name: "Fit Type"
      expr: fit_type
    - name: "Garment Category"
      expr: garment_category
    - name: "Garment Subcategory"
      expr: garment_subcategory
    - name: "Gender Target"
      expr: gender_target
    - name: "Grading Rules Reference"
      expr: grading_rules_reference
    - name: "Is Proprietary"
      expr: is_proprietary
    - name: "Last Modified Date"
      expr: last_modified_date
    - name: "Measurement Chart Url"
      expr: measurement_chart_url
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pattern Block"
      expr: COUNT(DISTINCT pattern_block_id)
    - name: "Total Ease Allowance Inches"
      expr: SUM(ease_allowance_inches)
    - name: "Average Ease Allowance Inches"
      expr: AVG(ease_allowance_inches)
    - name: "Total Seam Allowance Inches"
      expr: SUM(seam_allowance_inches)
    - name: "Average Seam Allowance Inches"
      expr: AVG(seam_allowance_inches)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`design_print_colorway`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Print Colorway business metrics"
  source: "`apparel_fashion_ecm`.`design`.`print_colorway`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Azo Free"
      expr: azo_free
    - name: "Cmyk Color Formula"
      expr: cmyk_color_formula
    - name: "Collection Name"
      expr: collection_name
    - name: "Color Fastness Rating"
      expr: color_fastness_rating
    - name: "Color Palette Description"
      expr: color_palette_description
    - name: "Colorway Code"
      expr: colorway_code
    - name: "Colorway Name"
      expr: colorway_name
    - name: "Colorway Status"
      expr: colorway_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Digital File Format"
      expr: digital_file_format
    - name: "Digital File Path"
      expr: digital_file_path
    - name: "Gender Target"
      expr: gender_target
    - name: "Hex Color Code"
      expr: hex_color_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Print Colorway"
      expr: COUNT(DISTINCT print_colorway_id)
    - name: "Total Unit Cost"
      expr: SUM(unit_cost)
    - name: "Average Unit Cost"
      expr: AVG(unit_cost)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`design_print_design`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Print Design business metrics"
  source: "`apparel_fashion_ecm`.`design`.`print_design`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Collection Name"
      expr: collection_name
    - name: "Color Count"
      expr: color_count
    - name: "Color Profile"
      expr: color_profile
    - name: "Colorway Count"
      expr: colorway_count
    - name: "Copyright Year"
      expr: copyright_year
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Design Medium"
      expr: design_medium
    - name: "Design Notes"
      expr: design_notes
    - name: "Design Status"
      expr: design_status
    - name: "Design Theme"
      expr: design_theme
    - name: "Fabric Compatibility"
      expr: fabric_compatibility
    - name: "Is Active"
      expr: is_active
    - name: "Is Licensed Artwork"
      expr: is_licensed_artwork
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Print Design"
      expr: COUNT(DISTINCT print_design_id)
    - name: "Total Master File Size Mb"
      expr: SUM(master_file_size_mb)
    - name: "Average Master File Size Mb"
      expr: AVG(master_file_size_mb)
    - name: "Total Repeat Height Cm"
      expr: SUM(repeat_height_cm)
    - name: "Average Repeat Height Cm"
      expr: AVG(repeat_height_cm)
    - name: "Total Repeat Width Cm"
      expr: SUM(repeat_width_cm)
    - name: "Average Repeat Width Cm"
      expr: AVG(repeat_width_cm)
    - name: "Total Royalty Rate Percent"
      expr: SUM(royalty_rate_percent)
    - name: "Average Royalty Rate Percent"
      expr: AVG(royalty_rate_percent)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`design_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Review business metrics"
  source: "`apparel_fashion_ecm`.`design`.`review`"
  dimensions:
    - name: "Agenda"
      expr: agenda
    - name: "Approval Status"
      expr: approval_status
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Commercial Feedback"
      expr: commercial_feedback
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "End Time"
      expr: end_time
    - name: "Follow Up Review Date"
      expr: follow_up_review_date
    - name: "Follow Up Review Scheduled"
      expr: follow_up_review_scheduled
    - name: "Is Confidential"
      expr: is_confidential
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Location"
      expr: location
    - name: "Meeting Minutes Url"
      expr: meeting_minutes_url
    - name: "Merchandising Feedback"
      expr: merchandising_feedback
    - name: "Next Action Due Date"
      expr: next_action_due_date
    - name: "Notes"
      expr: notes
    - name: "Participant List"
      expr: participant_list
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Review"
      expr: COUNT(DISTINCT review_id)
    - name: "Total Brand Alignment Score"
      expr: SUM(brand_alignment_score)
    - name: "Average Brand Alignment Score"
      expr: AVG(brand_alignment_score)
    - name: "Total Trend Alignment Score"
      expr: SUM(trend_alignment_score)
    - name: "Average Trend Alignment Score"
      expr: AVG(trend_alignment_score)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`design_review_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Review Item business metrics"
  source: "`apparel_fashion_ecm`.`design`.`review_item`"
  dimensions:
    - name: "Brand Alignment Score"
      expr: brand_alignment_score
    - name: "Color Story"
      expr: color_story
    - name: "Commercial Feedback"
      expr: commercial_feedback
    - name: "Competitive Benchmark"
      expr: competitive_benchmark
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Decision Rationale"
      expr: decision_rationale
    - name: "Decision Timestamp"
      expr: decision_timestamp
    - name: "Estimated Unit Volume"
      expr: estimated_unit_volume
    - name: "Fabric Type"
      expr: fabric_type
    - name: "Gender Target"
      expr: gender_target
    - name: "Is Active"
      expr: is_active
    - name: "Item Sequence Number"
      expr: item_sequence_number
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Price Tier"
      expr: price_tier
    - name: "Priority Ranking"
      expr: priority_ranking
    - name: "Product Category"
      expr: product_category
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Review Item"
      expr: COUNT(DISTINCT review_item_id)
    - name: "Total Estimated Cogs"
      expr: SUM(estimated_cogs)
    - name: "Average Estimated Cogs"
      expr: AVG(estimated_cogs)
    - name: "Total Estimated Retail Price"
      expr: SUM(estimated_retail_price)
    - name: "Average Estimated Retail Price"
      expr: AVG(estimated_retail_price)
    - name: "Total Estimated Wholesale Price"
      expr: SUM(estimated_wholesale_price)
    - name: "Average Estimated Wholesale Price"
      expr: AVG(estimated_wholesale_price)
    - name: "Total Target Margin Percentage"
      expr: SUM(target_margin_percentage)
    - name: "Average Target Margin Percentage"
      expr: AVG(target_margin_percentage)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`design_revision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revision business metrics"
  source: "`apparel_fashion_ecm`.`design`.`revision`"
  dimensions:
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Collaboration Notes"
      expr: collaboration_notes
    - name: "Colorway Change Description"
      expr: colorway_change_description
    - name: "Completion Timestamp"
      expr: completion_timestamp
    - name: "Construction Change Description"
      expr: construction_change_description
    - name: "Cost Impact Currency Code"
      expr: cost_impact_currency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Due Date"
      expr: due_date
    - name: "Instructions"
      expr: instructions
    - name: "Is Final Revision"
      expr: is_final_revision
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Original Cad File Path"
      expr: original_cad_file_path
    - name: "Print Pattern Change Description"
      expr: print_pattern_change_description
    - name: "Priority"
      expr: priority
    - name: "Product Category"
      expr: product_category
    - name: "Rejection Reason"
      expr: rejection_reason
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Revision"
      expr: COUNT(DISTINCT revision_id)
    - name: "Total Cycle Time Hours"
      expr: SUM(cycle_time_hours)
    - name: "Average Cycle Time Hours"
      expr: AVG(cycle_time_hours)
    - name: "Total Estimated Cost Impact"
      expr: SUM(estimated_cost_impact)
    - name: "Average Estimated Cost Impact"
      expr: AVG(estimated_cost_impact)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`design_sketch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sketch business metrics"
  source: "`apparel_fashion_ecm`.`design`.`sketch`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Collaboration Team"
      expr: collaboration_team
    - name: "Collection Name"
      expr: collection_name
    - name: "Color Palette Reference"
      expr: color_palette_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Design Notes"
      expr: design_notes
    - name: "Design Phase"
      expr: design_phase
    - name: "Fabric Suggestion"
      expr: fabric_suggestion
    - name: "File Format"
      expr: file_format
    - name: "File Path"
      expr: file_path
    - name: "Gender Target"
      expr: gender_target
    - name: "Is Active"
      expr: is_active
    - name: "Medium"
      expr: medium
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Primary Color Code"
      expr: primary_color_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sketch"
      expr: COUNT(DISTINCT sketch_id)
    - name: "Total Estimated Cogs"
      expr: SUM(estimated_cogs)
    - name: "Average Estimated Cogs"
      expr: AVG(estimated_cogs)
    - name: "Total Target Price Point"
      expr: SUM(target_price_point)
    - name: "Average Target Price Point"
      expr: AVG(target_price_point)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`design_trend_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trend Item business metrics"
  source: "`apparel_fashion_ecm`.`design`.`trend_item`"
  dimensions:
    - name: "Collection Adoption Flag"
      expr: collection_adoption_flag
    - name: "Color Palette"
      expr: color_palette
    - name: "Competitive Brand Adoption"
      expr: competitive_brand_adoption
    - name: "Consumer Segment"
      expr: consumer_segment
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Designer Brand"
      expr: designer_brand
    - name: "Forecast Longevity Months"
      expr: forecast_longevity_months
    - name: "Gender Relevance"
      expr: gender_relevance
    - name: "Geographic Relevance"
      expr: geographic_relevance
    - name: "Image Reference Url"
      expr: image_reference_url
    - name: "Influence Level"
      expr: influence_level
    - name: "Item Name"
      expr: item_name
    - name: "Logged By Analyst"
      expr: logged_by_analyst
    - name: "Material Composition"
      expr: material_composition
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Trend Item"
      expr: COUNT(DISTINCT trend_item_id)
    - name: "Total Adoption Score"
      expr: SUM(adoption_score)
    - name: "Average Adoption Score"
      expr: AVG(adoption_score)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`design_trend_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trend Report business metrics"
  source: "`apparel_fashion_ecm`.`design`.`trend_report`"
  dimensions:
    - name: "Adoption Recommendation"
      expr: adoption_recommendation
    - name: "Color Palette"
      expr: color_palette
    - name: "Consumer Segment"
      expr: consumer_segment
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cultural Influence"
      expr: cultural_influence
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Geographic Region"
      expr: geographic_region
    - name: "Key Trend Themes"
      expr: key_trend_themes
    - name: "Material Focus"
      expr: material_focus
    - name: "Print Pattern Theme"
      expr: print_pattern_theme
    - name: "Publication Date"
      expr: publication_date
    - name: "Report Author"
      expr: report_author
    - name: "Report Code"
      expr: report_code
    - name: "Report Document Url"
      expr: report_document_url
    - name: "Report Status"
      expr: report_status
    - name: "Report Title"
      expr: report_title
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Trend Report"
      expr: COUNT(DISTINCT trend_report_id)
    - name: "Total Relevance Score"
      expr: SUM(relevance_score)
    - name: "Average Relevance Score"
      expr: AVG(relevance_score)
$$;