-- Metric views for domain: design | Business: Semiconductors | Version: 2 | Generated on: 2026-06-24 02:09:37

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_ic_design_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ic Design Project business metrics"
  source: "`vibe_semiconductors_v1`.`design`.`ic_design_project`"
  dimensions:
    - name: "Block Count"
      expr: block_count
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Design Phase"
      expr: design_phase
    - name: "Design Type"
      expr: design_type
    - name: "Dfm Rule Set Version"
      expr: dfm_rule_set_version
    - name: "Dft Enabled"
      expr: dft_enabled
    - name: "Eda Tool Suite"
      expr: eda_tool_suite
    - name: "Eda Tool Version"
      expr: eda_tool_version
    - name: "Export Control Classification"
      expr: export_control_classification
    - name: "Gds File Path"
      expr: gds_file_path
    - name: "Iatf Automotive Grade"
      expr: iatf_automotive_grade
    - name: "Ip Core Count"
      expr: ip_core_count
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Lithography Type"
      expr: lithography_type
    - name: "Metal Layer Count"
      expr: metal_layer_count
    - name: "Packaging Type"
      expr: packaging_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ic Design Project"
      expr: COUNT(DISTINCT ic_design_project_id)
    - name: "Total Gate Count Target K"
      expr: SUM(gate_count_target_k)
    - name: "Average Gate Count Target K"
      expr: AVG(gate_count_target_k)
    - name: "Total Nre Actual Spend Usd"
      expr: SUM(nre_actual_spend_usd)
    - name: "Average Nre Actual Spend Usd"
      expr: AVG(nre_actual_spend_usd)
    - name: "Total Nre Budget Usd"
      expr: SUM(nre_budget_usd)
    - name: "Average Nre Budget Usd"
      expr: AVG(nre_budget_usd)
    - name: "Total Target Clock Freq Mhz"
      expr: SUM(target_clock_freq_mhz)
    - name: "Average Target Clock Freq Mhz"
      expr: AVG(target_clock_freq_mhz)
    - name: "Total Target Die Area Mm2"
      expr: SUM(target_die_area_mm2)
    - name: "Average Target Die Area Mm2"
      expr: AVG(target_die_area_mm2)
    - name: "Total Target Power Budget Mw"
      expr: SUM(target_power_budget_mw)
    - name: "Average Target Power Budget Mw"
      expr: AVG(target_power_budget_mw)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_ip_core`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ip Core business metrics"
  source: "`vibe_semiconductors_v1`.`design`.`ip_core`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Datasheet Url"
      expr: datasheet_url
    - name: "Design Ip Core Name"
      expr: design_ip_core_name
    - name: "Dfm Compliant"
      expr: dfm_compliant
    - name: "Dft Compliant"
      expr: dft_compliant
    - name: "Eda Tool Compatibility"
      expr: eda_tool_compatibility
    - name: "Export Control Classification"
      expr: export_control_classification
    - name: "Foundry Compatibility"
      expr: foundry_compatibility
    - name: "Function Category"
      expr: function_category
    - name: "Functional Description"
      expr: functional_description
    - name: "Gds Available"
      expr: gds_available
    - name: "Interface Standard"
      expr: interface_standard
    - name: "Ip Type"
      expr: ip_type
    - name: "Lef Available"
      expr: lef_available
    - name: "License Expiry Date"
      expr: license_expiry_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ip Core"
      expr: COUNT(DISTINCT ip_core_id)
    - name: "Total Area Um2"
      expr: SUM(area_um2)
    - name: "Average Area Um2"
      expr: AVG(area_um2)
    - name: "Total Gate Count"
      expr: SUM(gate_count)
    - name: "Average Gate Count"
      expr: AVG(gate_count)
    - name: "Total License Fee Usd"
      expr: SUM(license_fee_usd)
    - name: "Average License Fee Usd"
      expr: AVG(license_fee_usd)
    - name: "Total Max Frequency Mhz"
      expr: SUM(max_frequency_mhz)
    - name: "Average Max Frequency Mhz"
      expr: AVG(max_frequency_mhz)
    - name: "Total Power Uw"
      expr: SUM(power_uw)
    - name: "Average Power Uw"
      expr: AVG(power_uw)
    - name: "Total Royalty Rate Pct"
      expr: SUM(royalty_rate_pct)
    - name: "Average Royalty Rate Pct"
      expr: AVG(royalty_rate_pct)
    - name: "Total Scan Coverage Pct"
      expr: SUM(scan_coverage_pct)
    - name: "Average Scan Coverage Pct"
      expr: AVG(scan_coverage_pct)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_ip_core_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ip Core Usage business metrics"
  source: "`vibe_semiconductors_v1`.`design`.`ip_core_usage`"
  dimensions:
    - name: "Configuration Parameters"
      expr: configuration_parameters
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Design Hierarchy Path"
      expr: design_hierarchy_path
    - name: "Export Control Classification"
      expr: export_control_classification
    - name: "Instance Count"
      expr: instance_count
    - name: "Integration Start Date"
      expr: integration_start_date
    - name: "Integration Status"
      expr: integration_status
    - name: "Interface Protocol"
      expr: interface_protocol
    - name: "Ip Core Version"
      expr: ip_core_version
    - name: "Ip Reuse Flag"
      expr: ip_reuse_flag
    - name: "Is Dfm Compliant"
      expr: is_dfm_compliant
    - name: "Is Dft Enabled"
      expr: is_dft_enabled
    - name: "Is Silicon Proven"
      expr: is_silicon_proven
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "License Type"
      expr: license_type
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ip Core Usage"
      expr: COUNT(DISTINCT ip_core_usage_id)
    - name: "Total Area Consumed Um2"
      expr: SUM(area_consumed_um2)
    - name: "Average Area Consumed Um2"
      expr: AVG(area_consumed_um2)
    - name: "Total Clock Frequency Mhz"
      expr: SUM(clock_frequency_mhz)
    - name: "Average Clock Frequency Mhz"
      expr: AVG(clock_frequency_mhz)
    - name: "Total Functional Coverage Pct"
      expr: SUM(functional_coverage_pct)
    - name: "Average Functional Coverage Pct"
      expr: AVG(functional_coverage_pct)
    - name: "Total Nre Cost Usd"
      expr: SUM(nre_cost_usd)
    - name: "Average Nre Cost Usd"
      expr: AVG(nre_cost_usd)
    - name: "Total Power Contribution Mw"
      expr: SUM(power_contribution_mw)
    - name: "Average Power Contribution Mw"
      expr: AVG(power_contribution_mw)
    - name: "Total Royalty Rate Per Unit"
      expr: SUM(royalty_rate_per_unit)
    - name: "Average Royalty Rate Per Unit"
      expr: AVG(royalty_rate_per_unit)
    - name: "Total Supply Voltage V"
      expr: SUM(supply_voltage_v)
    - name: "Average Supply Voltage V"
      expr: AVG(supply_voltage_v)
    - name: "Total Timing Budget Ns"
      expr: SUM(timing_budget_ns)
    - name: "Average Timing Budget Ns"
      expr: AVG(timing_budget_ns)
    - name: "Total Usage To Core"
      expr: SUM(usage_to_core)
    - name: "Average Usage To Core"
      expr: AVG(usage_to_core)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_pdk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pdk business metrics"
  source: "`vibe_semiconductors_v1`.`design`.`pdk`"
  dimensions:
    - name: "Agile Plm Part Number"
      expr: agile_plm_part_number
    - name: "Checksum Sha256"
      expr: checksum_sha256
    - name: "Deprecation Date"
      expr: deprecation_date
    - name: "Dft Rule Deck Version"
      expr: dft_rule_deck_version
    - name: "Drc Rule Deck Version"
      expr: drc_rule_deck_version
    - name: "Eda Tool Compatibility"
      expr: eda_tool_compatibility
    - name: "Export Control Classification"
      expr: export_control_classification
    - name: "File Path"
      expr: file_path
    - name: "Gds Format"
      expr: gds_format
    - name: "Io Library Name"
      expr: io_library_name
    - name: "Ip Library Version"
      expr: ip_library_version
    - name: "Layer Stack Definition"
      expr: layer_stack_definition
    - name: "License Type"
      expr: license_type
    - name: "Lithography Type"
      expr: lithography_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pdk"
      expr: COUNT(DISTINCT pdk_id)
    - name: "Total Max Supply Voltage V"
      expr: SUM(max_supply_voltage_v)
    - name: "Average Max Supply Voltage V"
      expr: AVG(max_supply_voltage_v)
    - name: "Total Min Supply Voltage V"
      expr: SUM(min_supply_voltage_v)
    - name: "Average Min Supply Voltage V"
      expr: AVG(min_supply_voltage_v)
    - name: "Total Nominal Supply Voltage V"
      expr: SUM(nominal_supply_voltage_v)
    - name: "Average Nominal Supply Voltage V"
      expr: AVG(nominal_supply_voltage_v)
    - name: "Total Operating Temp Max C"
      expr: SUM(operating_temp_max_c)
    - name: "Average Operating Temp Max C"
      expr: AVG(operating_temp_max_c)
    - name: "Total Operating Temp Min C"
      expr: SUM(operating_temp_min_c)
    - name: "Average Operating Temp Min C"
      expr: AVG(operating_temp_min_c)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_physical_layout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical Layout business metrics"
  source: "`vibe_semiconductors_v1`.`design`.`physical_layout`"
  dimensions:
    - name: "Antenna Violation Count"
      expr: antenna_violation_count
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Drc Critical Violation Count"
      expr: drc_critical_violation_count
    - name: "Drc Violation Count"
      expr: drc_violation_count
    - name: "Eda Tool"
      expr: eda_tool
    - name: "Eda Tool Version"
      expr: eda_tool_version
    - name: "Em Compliant"
      expr: em_compliant
    - name: "Gds File Checksum"
      expr: gds_file_checksum
    - name: "Gds File Format"
      expr: gds_file_format
    - name: "Gds File Path"
      expr: gds_file_path
    - name: "Implementation Stage"
      expr: implementation_stage
    - name: "Iteration Timestamp"
      expr: iteration_timestamp
    - name: "Layout Name"
      expr: layout_name
    - name: "Layout Status"
      expr: layout_status
    - name: "Layout Version"
      expr: layout_version
    - name: "Lvs Clean"
      expr: lvs_clean
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Physical Layout"
      expr: COUNT(DISTINCT physical_layout_id)
    - name: "Total Cell Utilization Pct"
      expr: SUM(cell_utilization_pct)
    - name: "Average Cell Utilization Pct"
      expr: AVG(cell_utilization_pct)
    - name: "Total Core Area Mm2"
      expr: SUM(core_area_mm2)
    - name: "Average Core Area Mm2"
      expr: AVG(core_area_mm2)
    - name: "Total Cts Insertion Delay Ps"
      expr: SUM(cts_insertion_delay_ps)
    - name: "Average Cts Insertion Delay Ps"
      expr: AVG(cts_insertion_delay_ps)
    - name: "Total Cts Skew Ps"
      expr: SUM(cts_skew_ps)
    - name: "Average Cts Skew Ps"
      expr: AVG(cts_skew_ps)
    - name: "Total Dfm Score"
      expr: SUM(dfm_score)
    - name: "Average Dfm Score"
      expr: AVG(dfm_score)
    - name: "Total Dft Coverage Pct"
      expr: SUM(dft_coverage_pct)
    - name: "Average Dft Coverage Pct"
      expr: AVG(dft_coverage_pct)
    - name: "Total Die Area Mm2"
      expr: SUM(die_area_mm2)
    - name: "Average Die Area Mm2"
      expr: AVG(die_area_mm2)
    - name: "Total Die Height Um"
      expr: SUM(die_height_um)
    - name: "Average Die Height Um"
      expr: AVG(die_height_um)
    - name: "Total Die Width Um"
      expr: SUM(die_width_um)
    - name: "Average Die Width Um"
      expr: AVG(die_width_um)
    - name: "Total Ir Drop Max Mv"
      expr: SUM(ir_drop_max_mv)
    - name: "Average Ir Drop Max Mv"
      expr: AVG(ir_drop_max_mv)
    - name: "Total Leakage Power Uw"
      expr: SUM(leakage_power_uw)
    - name: "Average Leakage Power Uw"
      expr: AVG(leakage_power_uw)
    - name: "Total Metal Fill Density Pct"
      expr: SUM(metal_fill_density_pct)
    - name: "Average Metal Fill Density Pct"
      expr: AVG(metal_fill_density_pct)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_rtl_specification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rtl Specification business metrics"
  source: "`vibe_semiconductors_v1`.`design`.`rtl_specification`"
  dimensions:
    - name: "Ams Behavioral Model Ref"
      expr: ams_behavioral_model_ref
    - name: "Cdc Annotation Status"
      expr: cdc_annotation_status
    - name: "Clock Domain Count"
      expr: clock_domain_count
    - name: "Commit Hash"
      expr: commit_hash
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Design Block Name"
      expr: design_block_name
    - name: "Design Block Type"
      expr: design_block_type
    - name: "Design Intent Description"
      expr: design_intent_description
    - name: "Dfm Rule Set Version"
      expr: dfm_rule_set_version
    - name: "Dft Strategy"
      expr: dft_strategy
    - name: "Ear Eccn Code"
      expr: ear_eccn_code
    - name: "Fpga Device Family"
      expr: fpga_device_family
    - name: "Hdl Language"
      expr: hdl_language
    - name: "Interface Protocols"
      expr: interface_protocols
    - name: "Ip Reuse Source"
      expr: ip_reuse_source
    - name: "Is Analog Mixed Signal"
      expr: is_analog_mixed_signal
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rtl Specification"
      expr: COUNT(DISTINCT rtl_specification_id)
    - name: "Total Functional Coverage Target Pct"
      expr: SUM(functional_coverage_target_pct)
    - name: "Average Functional Coverage Target Pct"
      expr: AVG(functional_coverage_target_pct)
    - name: "Total Logic Gate Count Estimate"
      expr: SUM(logic_gate_count_estimate)
    - name: "Average Logic Gate Count Estimate"
      expr: AVG(logic_gate_count_estimate)
    - name: "Total Nre Cost Usd"
      expr: SUM(nre_cost_usd)
    - name: "Average Nre Cost Usd"
      expr: AVG(nre_cost_usd)
    - name: "Total Target Clock Frequency Mhz"
      expr: SUM(target_clock_frequency_mhz)
    - name: "Average Target Clock Frequency Mhz"
      expr: AVG(target_clock_frequency_mhz)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_tapeout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tapeout business metrics"
  source: "`vibe_semiconductors_v1`.`design`.`tapeout`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Design Name"
      expr: design_name
    - name: "Design Revision"
      expr: design_revision
    - name: "Design Type"
      expr: design_type
    - name: "Drc Clean"
      expr: drc_clean
    - name: "Erc Clean"
      expr: erc_clean
    - name: "Export Control Classification"
      expr: export_control_classification
    - name: "Foundry Name"
      expr: foundry_name
    - name: "Foundry Submission Ref"
      expr: foundry_submission_ref
    - name: "Gds File Path"
      expr: gds_file_path
    - name: "Gds File Version"
      expr: gds_file_version
    - name: "Ip Sign Off Complete"
      expr: ip_sign_off_complete
    - name: "Lithography Type"
      expr: lithography_type
    - name: "Lvs Clean"
      expr: lvs_clean
    - name: "Mask Count"
      expr: mask_count
    - name: "Metal Layer Count"
      expr: metal_layer_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tapeout"
      expr: COUNT(DISTINCT tapeout_id)
    - name: "Total Dfm Score"
      expr: SUM(dfm_score)
    - name: "Average Dfm Score"
      expr: AVG(dfm_score)
    - name: "Total Dft Coverage Pct"
      expr: SUM(dft_coverage_pct)
    - name: "Average Dft Coverage Pct"
      expr: AVG(dft_coverage_pct)
    - name: "Total Die Size Mm2"
      expr: SUM(die_size_mm2)
    - name: "Average Die Size Mm2"
      expr: AVG(die_size_mm2)
    - name: "Total Expected Yield Pct"
      expr: SUM(expected_yield_pct)
    - name: "Average Expected Yield Pct"
      expr: AVG(expected_yield_pct)
    - name: "Total Mask Cost Usd"
      expr: SUM(mask_cost_usd)
    - name: "Average Mask Cost Usd"
      expr: AVG(mask_cost_usd)
    - name: "Total Nre Cost Usd"
      expr: SUM(nre_cost_usd)
    - name: "Average Nre Cost Usd"
      expr: AVG(nre_cost_usd)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_timing_analysis_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Timing Analysis Run business metrics"
  source: "`vibe_semiconductors_v1`.`design`.`timing_analysis_run`"
  dimensions:
    - name: "Analysis Mode"
      expr: analysis_mode
    - name: "Clock Domain Count"
      expr: clock_domain_count
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Critical Path Count"
      expr: critical_path_count
    - name: "Design Stage"
      expr: design_stage
    - name: "Design Version"
      expr: design_version
    - name: "Hold Violation Count"
      expr: hold_violation_count
    - name: "Is Multi Corner Run"
      expr: is_multi_corner_run
    - name: "Is Signoff Run"
      expr: is_signoff_run
    - name: "Liberty Library Version"
      expr: liberty_library_version
    - name: "Max Capacitance Violation Count"
      expr: max_capacitance_violation_count
    - name: "Max Transition Violation Count"
      expr: max_transition_violation_count
    - name: "Primetime Version"
      expr: primetime_version
    - name: "Process Node Nm"
      expr: process_node_nm
    - name: "Pvt Corner"
      expr: pvt_corner
    - name: "Review Timestamp"
      expr: review_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Timing Analysis Run"
      expr: COUNT(DISTINCT timing_analysis_run_id)
    - name: "Total Clock Frequency Target Mhz"
      expr: SUM(clock_frequency_target_mhz)
    - name: "Average Clock Frequency Target Mhz"
      expr: AVG(clock_frequency_target_mhz)
    - name: "Total Clock Period Target Ps"
      expr: SUM(clock_period_target_ps)
    - name: "Average Clock Period Target Ps"
      expr: AVG(clock_period_target_ps)
    - name: "Total Derating Factor Hold"
      expr: SUM(derating_factor_hold)
    - name: "Average Derating Factor Hold"
      expr: AVG(derating_factor_hold)
    - name: "Total Derating Factor Setup"
      expr: SUM(derating_factor_setup)
    - name: "Average Derating Factor Setup"
      expr: AVG(derating_factor_setup)
    - name: "Total Supply Voltage V"
      expr: SUM(supply_voltage_v)
    - name: "Average Supply Voltage V"
      expr: AVG(supply_voltage_v)
    - name: "Total Temperature C"
      expr: SUM(temperature_c)
    - name: "Average Temperature C"
      expr: AVG(temperature_c)
    - name: "Total Total Hold Negative Slack Ps"
      expr: SUM(total_hold_negative_slack_ps)
    - name: "Average Total Hold Negative Slack Ps"
      expr: AVG(total_hold_negative_slack_ps)
    - name: "Total Total Negative Slack Ps"
      expr: SUM(total_negative_slack_ps)
    - name: "Average Total Negative Slack Ps"
      expr: AVG(total_negative_slack_ps)
    - name: "Total Worst Hold Slack Ps"
      expr: SUM(worst_hold_slack_ps)
    - name: "Average Worst Hold Slack Ps"
      expr: AVG(worst_hold_slack_ps)
    - name: "Total Worst Negative Slack Ps"
      expr: SUM(worst_negative_slack_ps)
    - name: "Average Worst Negative Slack Ps"
      expr: AVG(worst_negative_slack_ps)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_verification_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Verification Plan business metrics"
  source: "`vibe_semiconductors_v1`.`design`.`verification_plan`"
  dimensions:
    - name: "Bug Tracking Project Key"
      expr: bug_tracking_project_key
    - name: "Bug Tracking System"
      expr: bug_tracking_system
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Design Type"
      expr: design_type
    - name: "Dft Strategy"
      expr: dft_strategy
    - name: "Emulation Platform"
      expr: emulation_platform
    - name: "Fault Injection Campaign Planned"
      expr: fault_injection_campaign_planned
    - name: "Fmeda Document Reference"
      expr: fmeda_document_reference
    - name: "Formal Verification Tool"
      expr: formal_verification_tool
    - name: "Fpga Prototype Platform"
      expr: fpga_prototype_platform
    - name: "Ip Reuse Count"
      expr: ip_reuse_count
    - name: "Iso26262 Asil Decomposition"
      expr: iso26262_asil_decomposition
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Pdk Version"
      expr: pdk_version
    - name: "Plan End Date"
      expr: plan_end_date
    - name: "Plan Name"
      expr: plan_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Verification Plan"
      expr: COUNT(DISTINCT verification_plan_id)
    - name: "Total Assertion Coverage Target Pct"
      expr: SUM(assertion_coverage_target_pct)
    - name: "Average Assertion Coverage Target Pct"
      expr: AVG(assertion_coverage_target_pct)
    - name: "Total Code Coverage Target Pct"
      expr: SUM(code_coverage_target_pct)
    - name: "Average Code Coverage Target Pct"
      expr: AVG(code_coverage_target_pct)
    - name: "Total Fault Coverage Target Pct"
      expr: SUM(fault_coverage_target_pct)
    - name: "Average Fault Coverage Target Pct"
      expr: AVG(fault_coverage_target_pct)
    - name: "Total Functional Coverage Target Pct"
      expr: SUM(functional_coverage_target_pct)
    - name: "Average Functional Coverage Target Pct"
      expr: AVG(functional_coverage_target_pct)
    - name: "Total Safety Mechanism Coverage Target Pct"
      expr: SUM(safety_mechanism_coverage_target_pct)
    - name: "Average Safety Mechanism Coverage Target Pct"
      expr: AVG(safety_mechanism_coverage_target_pct)
    - name: "Total Toggle Coverage Target Pct"
      expr: SUM(toggle_coverage_target_pct)
    - name: "Average Toggle Coverage Target Pct"
      expr: AVG(toggle_coverage_target_pct)
$$;