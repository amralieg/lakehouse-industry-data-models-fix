-- Cross-Domain Foreign Keys for Business: Shipping Ports | Version: v1_ecm
-- Generated on: 2026-05-10 03:48:17
-- Total cross-domain FK constraints: 1901
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: asset, billing, booking, cargo, compliance, contract, customer, finance, infrastructure, intermodal, marine, masterdata, procurement, safety, security, tariff, terminal, vessel, workforce

-- ========= asset --> compliance (4 constraint(s)) =========
-- Requires: asset schema, compliance schema
ALTER TABLE `shipping_ports_ecm`.`asset`.`swl_certificate` ADD CONSTRAINT `fk_asset_swl_certificate_compliance_audit_id` FOREIGN KEY (`compliance_audit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`compliance_audit`(`compliance_audit_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_compliance_audit_id` FOREIGN KEY (`compliance_audit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`compliance_audit`(`compliance_audit_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`inspection_record` ADD CONSTRAINT `fk_asset_inspection_record_compliance_audit_id` FOREIGN KEY (`compliance_audit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`compliance_audit`(`compliance_audit_id`);

-- ========= asset --> contract (5 constraint(s)) =========
-- Requires: asset schema, contract schema
ALTER TABLE `shipping_ports_ecm`.`asset`.`port_asset` ADD CONSTRAINT `fk_asset_port_asset_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`maintenance_plan` ADD CONSTRAINT `fk_asset_maintenance_plan_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`downtime_record` ADD CONSTRAINT `fk_asset_downtime_record_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= asset --> customer (8 constraint(s)) =========
-- Requires: asset schema, customer schema
ALTER TABLE `shipping_ports_ecm`.`asset`.`port_asset` ADD CONSTRAINT `fk_asset_port_asset_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`maintenance_plan` ADD CONSTRAINT `fk_asset_maintenance_plan_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`inspection_record` ADD CONSTRAINT `fk_asset_inspection_record_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`acquisition` ADD CONSTRAINT `fk_asset_acquisition_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`disposal` ADD CONSTRAINT `fk_asset_disposal_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);

-- ========= asset --> finance (9 constraint(s)) =========
-- Requires: asset schema, finance schema
ALTER TABLE `shipping_ports_ecm`.`asset`.`port_asset` ADD CONSTRAINT `fk_asset_port_asset_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`depreciation_schedule` ADD CONSTRAINT `fk_asset_depreciation_schedule_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`depreciation_schedule` ADD CONSTRAINT `fk_asset_depreciation_schedule_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `shipping_ports_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`maintenance_plan` ADD CONSTRAINT `fk_asset_maintenance_plan_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`acquisition` ADD CONSTRAINT `fk_asset_acquisition_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`acquisition` ADD CONSTRAINT `fk_asset_acquisition_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `shipping_ports_ecm`.`finance`.`wbs_element`(`wbs_element_id`);

-- ========= asset --> marine (5 constraint(s)) =========
-- Requires: asset schema, marine schema
ALTER TABLE `shipping_ports_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_tug_id` FOREIGN KEY (`tug_id`) REFERENCES `shipping_ports_ecm`.`marine`.`tug`(`tug_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_tug_id` FOREIGN KEY (`tug_id`) REFERENCES `shipping_ports_ecm`.`marine`.`tug`(`tug_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`downtime_record` ADD CONSTRAINT `fk_asset_downtime_record_tug_id` FOREIGN KEY (`tug_id`) REFERENCES `shipping_ports_ecm`.`marine`.`tug`(`tug_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`inspection_record` ADD CONSTRAINT `fk_asset_inspection_record_tug_id` FOREIGN KEY (`tug_id`) REFERENCES `shipping_ports_ecm`.`marine`.`tug`(`tug_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`meter` ADD CONSTRAINT `fk_asset_meter_tug_id` FOREIGN KEY (`tug_id`) REFERENCES `shipping_ports_ecm`.`marine`.`tug`(`tug_id`);

-- ========= asset --> masterdata (5 constraint(s)) =========
-- Requires: asset schema, masterdata schema
ALTER TABLE `shipping_ports_ecm`.`asset`.`port_asset` ADD CONSTRAINT `fk_asset_port_asset_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`port_asset` ADD CONSTRAINT `fk_asset_port_asset_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`equipment_class` ADD CONSTRAINT `fk_asset_equipment_class_equipment_type_id` FOREIGN KEY (`equipment_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`equipment_type`(`equipment_type_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`work_order_template` ADD CONSTRAINT `fk_asset_work_order_template_equipment_type_id` FOREIGN KEY (`equipment_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`equipment_type`(`equipment_type_id`);

-- ========= asset --> procurement (6 constraint(s)) =========
-- Requires: asset schema, procurement schema
ALTER TABLE `shipping_ports_ecm`.`asset`.`equipment_class` ADD CONSTRAINT `fk_asset_equipment_class_material_group_id` FOREIGN KEY (`material_group_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`material_group`(`material_group_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`maintenance_plan` ADD CONSTRAINT `fk_asset_maintenance_plan_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`inspection_record` ADD CONSTRAINT `fk_asset_inspection_record_service_entry_sheet_id` FOREIGN KEY (`service_entry_sheet_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`service_entry_sheet`(`service_entry_sheet_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`acquisition` ADD CONSTRAINT `fk_asset_acquisition_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= asset --> safety (5 constraint(s)) =========
-- Requires: asset schema, safety schema
ALTER TABLE `shipping_ports_ecm`.`asset`.`maintenance_plan` ADD CONSTRAINT `fk_asset_maintenance_plan_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `shipping_ports_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `shipping_ports_ecm`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_ohs_incident_id` FOREIGN KEY (`ohs_incident_id`) REFERENCES `shipping_ports_ecm`.`safety`.`ohs_incident`(`ohs_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`inspection_record` ADD CONSTRAINT `fk_asset_inspection_record_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `shipping_ports_ecm`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`acquisition` ADD CONSTRAINT `fk_asset_acquisition_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `shipping_ports_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);

-- ========= asset --> security (12 constraint(s)) =========
-- Requires: asset schema, security schema
ALTER TABLE `shipping_ports_ecm`.`asset`.`port_asset` ADD CONSTRAINT `fk_asset_port_asset_facility_security_plan_id` FOREIGN KEY (`facility_security_plan_id`) REFERENCES `shipping_ports_ecm`.`security`.`facility_security_plan`(`facility_security_plan_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`port_asset` ADD CONSTRAINT `fk_asset_port_asset_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`swl_certificate` ADD CONSTRAINT `fk_asset_swl_certificate_personnel_id` FOREIGN KEY (`personnel_id`) REFERENCES `shipping_ports_ecm`.`security`.`personnel`(`personnel_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`maintenance_plan` ADD CONSTRAINT `fk_asset_maintenance_plan_personnel_id` FOREIGN KEY (`personnel_id`) REFERENCES `shipping_ports_ecm`.`security`.`personnel`(`personnel_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_personnel_id` FOREIGN KEY (`personnel_id`) REFERENCES `shipping_ports_ecm`.`security`.`personnel`(`personnel_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`downtime_record` ADD CONSTRAINT `fk_asset_downtime_record_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`inspection_record` ADD CONSTRAINT `fk_asset_inspection_record_personnel_id` FOREIGN KEY (`personnel_id`) REFERENCES `shipping_ports_ecm`.`security`.`personnel`(`personnel_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`acquisition` ADD CONSTRAINT `fk_asset_acquisition_facility_security_plan_id` FOREIGN KEY (`facility_security_plan_id`) REFERENCES `shipping_ports_ecm`.`security`.`facility_security_plan`(`facility_security_plan_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`disposal` ADD CONSTRAINT `fk_asset_disposal_personnel_id` FOREIGN KEY (`personnel_id`) REFERENCES `shipping_ports_ecm`.`security`.`personnel`(`personnel_id`);

-- ========= asset --> terminal (5 constraint(s)) =========
-- Requires: asset schema, terminal schema
ALTER TABLE `shipping_ports_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_terminal_equipment_id` FOREIGN KEY (`terminal_equipment_id`) REFERENCES `shipping_ports_ecm`.`terminal`.`terminal_equipment`(`terminal_equipment_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_terminal_equipment_id` FOREIGN KEY (`terminal_equipment_id`) REFERENCES `shipping_ports_ecm`.`terminal`.`terminal_equipment`(`terminal_equipment_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`downtime_record` ADD CONSTRAINT `fk_asset_downtime_record_terminal_equipment_id` FOREIGN KEY (`terminal_equipment_id`) REFERENCES `shipping_ports_ecm`.`terminal`.`terminal_equipment`(`terminal_equipment_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`inspection_record` ADD CONSTRAINT `fk_asset_inspection_record_terminal_equipment_id` FOREIGN KEY (`terminal_equipment_id`) REFERENCES `shipping_ports_ecm`.`terminal`.`terminal_equipment`(`terminal_equipment_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`meter` ADD CONSTRAINT `fk_asset_meter_terminal_equipment_id` FOREIGN KEY (`terminal_equipment_id`) REFERENCES `shipping_ports_ecm`.`terminal`.`terminal_equipment`(`terminal_equipment_id`);

-- ========= asset --> vessel (2 constraint(s)) =========
-- Requires: asset schema, vessel schema
ALTER TABLE `shipping_ports_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`downtime_record` ADD CONSTRAINT `fk_asset_downtime_record_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);

-- ========= asset --> workforce (14 constraint(s)) =========
-- Requires: asset schema, workforce schema
ALTER TABLE `shipping_ports_ecm`.`asset`.`maintenance_plan` ADD CONSTRAINT `fk_asset_maintenance_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_tertiary_work_approved_by_employee_id` FOREIGN KEY (`tertiary_work_approved_by_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_gang_id` FOREIGN KEY (`gang_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`gang`(`gang_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`work_order_task` ADD CONSTRAINT `fk_asset_work_order_task_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`downtime_record` ADD CONSTRAINT `fk_asset_downtime_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`downtime_record` ADD CONSTRAINT `fk_asset_downtime_record_shift_pattern_id` FOREIGN KEY (`shift_pattern_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`shift_pattern`(`shift_pattern_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`downtime_record` ADD CONSTRAINT `fk_asset_downtime_record_tertiary_downtime_approved_by_user_employee_id` FOREIGN KEY (`tertiary_downtime_approved_by_user_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`inspection_record` ADD CONSTRAINT `fk_asset_inspection_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`meter` ADD CONSTRAINT `fk_asset_meter_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`acquisition` ADD CONSTRAINT `fk_asset_acquisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`acquisition` ADD CONSTRAINT `fk_asset_acquisition_acquisition_employee_id` FOREIGN KEY (`acquisition_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`asset`.`task_part_consumption` ADD CONSTRAINT `fk_asset_task_part_consumption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= billing --> cargo (1 constraint(s)) =========
-- Requires: billing schema, cargo schema
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`shipment`(`shipment_id`);

-- ========= billing --> compliance (11 constraint(s)) =========
-- Requires: billing schema, compliance schema
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`hs_code`(`hs_code_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`hs_code`(`hs_code_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_trade_document_id` FOREIGN KEY (`trade_document_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`trade_document`(`trade_document_id`);

-- ========= billing --> contract (6 constraint(s)) =========
-- Requires: billing schema, contract schema
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `shipping_ports_ecm`.`contract`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `shipping_ports_ecm`.`contract`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`proforma_invoice` ADD CONSTRAINT `fk_billing_proforma_invoice_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= billing --> customer (12 constraint(s)) =========
-- Requires: billing schema, customer schema
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`debit_note` ADD CONSTRAINT `fk_billing_debit_note_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_service_request_id` FOREIGN KEY (`service_request_id`) REFERENCES `shipping_ports_ecm`.`customer`.`service_request`(`service_request_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`dunning_notice` ADD CONSTRAINT `fk_billing_dunning_notice_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`proforma_invoice` ADD CONSTRAINT `fk_billing_proforma_invoice_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`statement_of_account` ADD CONSTRAINT `fk_billing_statement_of_account_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`billing_cycle` ADD CONSTRAINT `fk_billing_billing_cycle_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);

-- ========= billing --> finance (15 constraint(s)) =========
-- Requires: billing schema, finance schema
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`debit_note` ADD CONSTRAINT `fk_billing_debit_note_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);

-- ========= billing --> infrastructure (11 constraint(s)) =========
-- Requires: billing schema, infrastructure schema
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_anchorage_area_id` FOREIGN KEY (`anchorage_area_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`anchorage_area`(`anchorage_area_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`channel`(`channel_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_closure_id` FOREIGN KEY (`closure_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`closure`(`closure_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_dredging_campaign_id` FOREIGN KEY (`dredging_campaign_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`dredging_campaign`(`dredging_campaign_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_port_gate_id` FOREIGN KEY (`port_gate_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port_gate`(`port_gate_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`billing_cycle` ADD CONSTRAINT `fk_billing_billing_cycle_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal`(`terminal_id`);

-- ========= billing --> intermodal (9 constraint(s)) =========
-- Requires: billing schema, intermodal schema
ALTER TABLE `shipping_ports_ecm`.`billing`.`debit_note` ADD CONSTRAINT `fk_billing_debit_note_edi_message_id` FOREIGN KEY (`edi_message_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`edi_message`(`edi_message_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`receivable_account` ADD CONSTRAINT `fk_billing_receivable_account_haulier_id` FOREIGN KEY (`haulier_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`haulier`(`haulier_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`receivable_account` ADD CONSTRAINT `fk_billing_receivable_account_rail_operator_id` FOREIGN KEY (`rail_operator_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`rail_operator`(`rail_operator_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_drayage_order_id` FOREIGN KEY (`drayage_order_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`drayage_order`(`drayage_order_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`leg`(`leg_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_rail_visit_id` FOREIGN KEY (`rail_visit_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`rail_visit`(`rail_visit_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_truck_visit_id` FOREIGN KEY (`truck_visit_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`truck_visit`(`truck_visit_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`proforma_invoice` ADD CONSTRAINT `fk_billing_proforma_invoice_slot_booking_id` FOREIGN KEY (`slot_booking_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`slot_booking`(`slot_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`statement_of_account` ADD CONSTRAINT `fk_billing_statement_of_account_edi_message_id` FOREIGN KEY (`edi_message_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`edi_message`(`edi_message_id`);

-- ========= billing --> marine (1 constraint(s)) =========
-- Requires: billing schema, marine schema
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_marine_service_order_id` FOREIGN KEY (`marine_service_order_id`) REFERENCES `shipping_ports_ecm`.`marine`.`marine_service_order`(`marine_service_order_id`);

-- ========= billing --> masterdata (15 constraint(s)) =========
-- Requires: billing schema, masterdata schema
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_flag_state_id` FOREIGN KEY (`flag_state_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`flag_state`(`flag_state_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`container_type`(`container_type_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_service_code_id` FOREIGN KEY (`service_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`service_code`(`service_code_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`debit_note` ADD CONSTRAINT `fk_billing_debit_note_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`receivable_account` ADD CONSTRAINT `fk_billing_receivable_account_edi_partner_id` FOREIGN KEY (`edi_partner_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`edi_partner`(`edi_partner_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_service_code_id` FOREIGN KEY (`service_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`service_code`(`service_code_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`container_type`(`container_type_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_service_code_id` FOREIGN KEY (`service_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`service_code`(`service_code_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`proforma_invoice` ADD CONSTRAINT `fk_billing_proforma_invoice_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`proforma_invoice` ADD CONSTRAINT `fk_billing_proforma_invoice_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);

-- ========= billing --> safety (7 constraint(s)) =========
-- Requires: billing schema, safety schema
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_contractor_safety_id` FOREIGN KEY (`contractor_safety_id`) REFERENCES `shipping_ports_ecm`.`safety`.`contractor_safety`(`contractor_safety_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_marpol_waste_record_id` FOREIGN KEY (`marpol_waste_record_id`) REFERENCES `shipping_ports_ecm`.`safety`.`marpol_waste_record`(`marpol_waste_record_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_ohs_incident_id` FOREIGN KEY (`ohs_incident_id`) REFERENCES `shipping_ports_ecm`.`safety`.`ohs_incident`(`ohs_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`debit_note` ADD CONSTRAINT `fk_billing_debit_note_ohs_incident_id` FOREIGN KEY (`ohs_incident_id`) REFERENCES `shipping_ports_ecm`.`safety`.`ohs_incident`(`ohs_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_sustainability_initiative_id` FOREIGN KEY (`sustainability_initiative_id`) REFERENCES `shipping_ports_ecm`.`safety`.`sustainability_initiative`(`sustainability_initiative_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_contractor_safety_id` FOREIGN KEY (`contractor_safety_id`) REFERENCES `shipping_ports_ecm`.`safety`.`contractor_safety`(`contractor_safety_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `shipping_ports_ecm`.`safety`.`permit_to_work`(`permit_to_work_id`);

-- ========= billing --> security (3 constraint(s)) =========
-- Requires: billing schema, security schema
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);

-- ========= billing --> tariff (8 constraint(s)) =========
-- Requires: billing schema, tariff schema
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_port_tariff_id` FOREIGN KEY (`port_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_tariff`(`port_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_item_id` FOREIGN KEY (`item_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`item`(`item_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_rate_card_line_id` FOREIGN KEY (`rate_card_line_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card_line`(`rate_card_line_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_exception_id` FOREIGN KEY (`exception_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`exception`(`exception_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`debit_note` ADD CONSTRAINT `fk_billing_debit_note_item_id` FOREIGN KEY (`item_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`item`(`item_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_item_id` FOREIGN KEY (`item_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`item`(`item_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`proforma_invoice` ADD CONSTRAINT `fk_billing_proforma_invoice_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);

-- ========= billing --> terminal (2 constraint(s)) =========
-- Requires: billing schema, terminal schema
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_terminal_equipment_id` FOREIGN KEY (`terminal_equipment_id`) REFERENCES `shipping_ports_ecm`.`terminal`.`terminal_equipment`(`terminal_equipment_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_terminal_equipment_id` FOREIGN KEY (`terminal_equipment_id`) REFERENCES `shipping_ports_ecm`.`terminal`.`terminal_equipment`(`terminal_equipment_id`);

-- ========= billing --> vessel (8 constraint(s)) =========
-- Requires: billing schema, vessel schema
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`debit_note` ADD CONSTRAINT `fk_billing_debit_note_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_charge_vessel_call_id` FOREIGN KEY (`charge_vessel_call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`proforma_invoice` ADD CONSTRAINT `fk_billing_proforma_invoice_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);

-- ========= billing --> workforce (18 constraint(s)) =========
-- Requires: billing schema, workforce schema
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`debit_note` ADD CONSTRAINT `fk_billing_debit_note_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`debit_note` ADD CONSTRAINT `fk_billing_debit_note_tertiary_debit_modified_by_employee_id` FOREIGN KEY (`tertiary_debit_modified_by_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`receivable_account` ADD CONSTRAINT `fk_billing_receivable_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`dunning_notice` ADD CONSTRAINT `fk_billing_dunning_notice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`run` ADD CONSTRAINT `fk_billing_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`run` ADD CONSTRAINT `fk_billing_run_run_employee_id` FOREIGN KEY (`run_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`proforma_invoice` ADD CONSTRAINT `fk_billing_proforma_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`statement_of_account` ADD CONSTRAINT `fk_billing_statement_of_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`statement_of_account` ADD CONSTRAINT `fk_billing_statement_of_account_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`billing_cycle` ADD CONSTRAINT `fk_billing_billing_cycle_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`billing_cycle` ADD CONSTRAINT `fk_billing_billing_cycle_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`billing_cycle` ADD CONSTRAINT `fk_billing_billing_cycle_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= booking --> asset (4 constraint(s)) =========
-- Requires: booking schema, asset schema
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ADD CONSTRAINT `fk_booking_booking_service_order_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_berth_reservation` ADD CONSTRAINT `fk_booking_booking_berth_reservation_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_anchorage_booking` ADD CONSTRAINT `fk_booking_booking_anchorage_booking_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`resource_allocation` ADD CONSTRAINT `fk_booking_resource_allocation_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);

-- ========= booking --> billing (5 constraint(s)) =========
-- Requires: booking schema, billing schema
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ADD CONSTRAINT `fk_booking_call_booking_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_berth_reservation` ADD CONSTRAINT `fk_booking_booking_berth_reservation_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_anchorage_booking` ADD CONSTRAINT `fk_booking_booking_anchorage_booking_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= booking --> cargo (4 constraint(s)) =========
-- Requires: booking schema, cargo schema
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_berth_reservation` ADD CONSTRAINT `fk_booking_booking_berth_reservation_handling_order_id` FOREIGN KEY (`handling_order_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`handling_order`(`handling_order_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ADD CONSTRAINT `fk_booking_slot_reservation_container_id` FOREIGN KEY (`container_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`container`(`container_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_container_id` FOREIGN KEY (`container_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`container`(`container_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ADD CONSTRAINT `fk_booking_voyage_nomination_container_preadvice_id` FOREIGN KEY (`container_preadvice_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`container_preadvice`(`container_preadvice_id`);

-- ========= booking --> compliance (10 constraint(s)) =========
-- Requires: booking schema, compliance schema
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ADD CONSTRAINT `fk_booking_call_booking_marpol_record_id` FOREIGN KEY (`marpol_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`marpol_record`(`marpol_record_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ADD CONSTRAINT `fk_booking_call_booking_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ADD CONSTRAINT `fk_booking_booking_service_order_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ADD CONSTRAINT `fk_booking_booking_service_order_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_berth_reservation` ADD CONSTRAINT `fk_booking_booking_berth_reservation_compliance_audit_id` FOREIGN KEY (`compliance_audit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`compliance_audit`(`compliance_audit_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_berth_reservation` ADD CONSTRAINT `fk_booking_booking_berth_reservation_isps_facility_record_id` FOREIGN KEY (`isps_facility_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`isps_facility_record`(`isps_facility_record_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`hs_code`(`hs_code_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ADD CONSTRAINT `fk_booking_pre_arrival_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_anchorage_booking` ADD CONSTRAINT `fk_booking_booking_anchorage_booking_isps_facility_record_id` FOREIGN KEY (`isps_facility_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`isps_facility_record`(`isps_facility_record_id`);

-- ========= booking --> contract (5 constraint(s)) =========
-- Requires: booking schema, contract schema
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ADD CONSTRAINT `fk_booking_call_booking_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ADD CONSTRAINT `fk_booking_booking_service_order_service_scope_id` FOREIGN KEY (`service_scope_id`) REFERENCES `shipping_ports_ecm`.`contract`.`service_scope`(`service_scope_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ADD CONSTRAINT `fk_booking_booking_service_order_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `shipping_ports_ecm`.`contract`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_berth_reservation` ADD CONSTRAINT `fk_booking_booking_berth_reservation_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= booking --> customer (7 constraint(s)) =========
-- Requires: booking schema, customer schema
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ADD CONSTRAINT `fk_booking_call_booking_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_primary_cargo_port_community_participant_id` FOREIGN KEY (`primary_cargo_port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_quaternary_cargo_freight_forwarder_port_community_participant_id` FOREIGN KEY (`quaternary_cargo_freight_forwarder_port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_tertiary_cargo_notify_party_port_community_participant_id` FOREIGN KEY (`tertiary_cargo_notify_party_port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`amendment` ADD CONSTRAINT `fk_booking_amendment_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);

-- ========= booking --> finance (10 constraint(s)) =========
-- Requires: booking schema, finance schema
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ADD CONSTRAINT `fk_booking_call_booking_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ADD CONSTRAINT `fk_booking_call_booking_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ADD CONSTRAINT `fk_booking_booking_service_order_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ADD CONSTRAINT `fk_booking_booking_service_order_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_berth_reservation` ADD CONSTRAINT `fk_booking_booking_berth_reservation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_anchorage_booking` ADD CONSTRAINT `fk_booking_booking_anchorage_booking_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`resource_allocation` ADD CONSTRAINT `fk_booking_resource_allocation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`resource_allocation` ADD CONSTRAINT `fk_booking_resource_allocation_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`resource_allocation` ADD CONSTRAINT `fk_booking_resource_allocation_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `shipping_ports_ecm`.`finance`.`wbs_element`(`wbs_element_id`);

-- ========= booking --> infrastructure (12 constraint(s)) =========
-- Requires: booking schema, infrastructure schema
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ADD CONSTRAINT `fk_booking_booking_service_order_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ADD CONSTRAINT `fk_booking_booking_service_order_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ADD CONSTRAINT `fk_booking_booking_service_order_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_berth_reservation` ADD CONSTRAINT `fk_booking_booking_berth_reservation_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ADD CONSTRAINT `fk_booking_pre_arrival_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`channel`(`channel_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_port_gate_id` FOREIGN KEY (`port_gate_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port_gate`(`port_gate_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ADD CONSTRAINT `fk_booking_voyage_nomination_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ADD CONSTRAINT `fk_booking_voyage_nomination_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_anchorage_booking` ADD CONSTRAINT `fk_booking_booking_anchorage_booking_anchorage_area_id` FOREIGN KEY (`anchorage_area_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`anchorage_area`(`anchorage_area_id`);

-- ========= booking --> intermodal (2 constraint(s)) =========
-- Requires: booking schema, intermodal schema
ALTER TABLE `shipping_ports_ecm`.`booking`.`amendment` ADD CONSTRAINT `fk_booking_amendment_edi_message_id` FOREIGN KEY (`edi_message_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`edi_message`(`edi_message_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ADD CONSTRAINT `fk_booking_voyage_nomination_edi_message_id` FOREIGN KEY (`edi_message_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`edi_message`(`edi_message_id`);

-- ========= booking --> masterdata (24 constraint(s)) =========
-- Requires: booking schema, masterdata schema
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ADD CONSTRAINT `fk_booking_call_booking_un_locode_id` FOREIGN KEY (`un_locode_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`un_locode`(`un_locode_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ADD CONSTRAINT `fk_booking_call_booking_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ADD CONSTRAINT `fk_booking_call_booking_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ADD CONSTRAINT `fk_booking_booking_service_order_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ADD CONSTRAINT `fk_booking_booking_service_order_service_code_id` FOREIGN KEY (`service_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`service_code`(`service_code_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`container_type`(`container_type_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_un_locode_id` FOREIGN KEY (`un_locode_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`un_locode`(`un_locode_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ADD CONSTRAINT `fk_booking_slot_reservation_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ADD CONSTRAINT `fk_booking_pre_arrival_un_locode_id` FOREIGN KEY (`un_locode_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`un_locode`(`un_locode_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ADD CONSTRAINT `fk_booking_pre_arrival_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ADD CONSTRAINT `fk_booking_voyage_nomination_un_locode_id` FOREIGN KEY (`un_locode_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`un_locode`(`un_locode_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ADD CONSTRAINT `fk_booking_voyage_nomination_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ADD CONSTRAINT `fk_booking_voyage_nomination_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ADD CONSTRAINT `fk_booking_service_requirement_service_code_id` FOREIGN KEY (`service_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`service_code`(`service_code_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_anchorage_booking` ADD CONSTRAINT `fk_booking_booking_anchorage_booking_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`resource_allocation` ADD CONSTRAINT `fk_booking_resource_allocation_equipment_type_id` FOREIGN KEY (`equipment_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`equipment_type`(`equipment_type_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`resource_allocation` ADD CONSTRAINT `fk_booking_resource_allocation_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`resource_allocation` ADD CONSTRAINT `fk_booking_resource_allocation_resource_id` FOREIGN KEY (`resource_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`resource`(`resource_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`confirmation` ADD CONSTRAINT `fk_booking_confirmation_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);

-- ========= booking --> security (10 constraint(s)) =========
-- Requires: booking schema, security schema
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_berth_reservation` ADD CONSTRAINT `fk_booking_booking_berth_reservation_dos_record_id` FOREIGN KEY (`dos_record_id`) REFERENCES `shipping_ports_ecm`.`security`.`dos_record`(`dos_record_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_berth_reservation` ADD CONSTRAINT `fk_booking_booking_berth_reservation_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_screening_record_id` FOREIGN KEY (`screening_record_id`) REFERENCES `shipping_ports_ecm`.`security`.`screening_record`(`screening_record_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ADD CONSTRAINT `fk_booking_pre_arrival_dos_record_id` FOREIGN KEY (`dos_record_id`) REFERENCES `shipping_ports_ecm`.`security`.`dos_record`(`dos_record_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_access_event_id` FOREIGN KEY (`access_event_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_event`(`access_event_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_screening_record_id` FOREIGN KEY (`screening_record_id`) REFERENCES `shipping_ports_ecm`.`security`.`screening_record`(`screening_record_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_anchorage_booking` ADD CONSTRAINT `fk_booking_booking_anchorage_booking_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_anchorage_booking` ADD CONSTRAINT `fk_booking_booking_anchorage_booking_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`resource_allocation` ADD CONSTRAINT `fk_booking_resource_allocation_personnel_id` FOREIGN KEY (`personnel_id`) REFERENCES `shipping_ports_ecm`.`security`.`personnel`(`personnel_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`vessel_call_security_assignment` ADD CONSTRAINT `fk_booking_vessel_call_security_assignment_personnel_id` FOREIGN KEY (`personnel_id`) REFERENCES `shipping_ports_ecm`.`security`.`personnel`(`personnel_id`);

-- ========= booking --> tariff (18 constraint(s)) =========
-- Requires: booking schema, tariff schema
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ADD CONSTRAINT `fk_booking_call_booking_port_tariff_id` FOREIGN KEY (`port_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_tariff`(`port_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ADD CONSTRAINT `fk_booking_call_booking_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ADD CONSTRAINT `fk_booking_booking_service_order_item_id` FOREIGN KEY (`item_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`item`(`item_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ADD CONSTRAINT `fk_booking_booking_service_order_rate_card_line_id` FOREIGN KEY (`rate_card_line_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card_line`(`rate_card_line_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_berth_reservation` ADD CONSTRAINT `fk_booking_booking_berth_reservation_mooring_tariff_id` FOREIGN KEY (`mooring_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`mooring_tariff`(`mooring_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_berth_reservation` ADD CONSTRAINT `fk_booking_booking_berth_reservation_pilotage_tariff_id` FOREIGN KEY (`pilotage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`pilotage_tariff`(`pilotage_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_berth_reservation` ADD CONSTRAINT `fk_booking_booking_berth_reservation_port_tariff_id` FOREIGN KEY (`port_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_tariff`(`port_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_berth_reservation` ADD CONSTRAINT `fk_booking_booking_berth_reservation_towage_tariff_id` FOREIGN KEY (`towage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`towage_tariff`(`towage_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_storage_tariff_id` FOREIGN KEY (`storage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`storage_tariff`(`storage_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_thc_schedule_id` FOREIGN KEY (`thc_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`thc_schedule`(`thc_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_wharfage_schedule_id` FOREIGN KEY (`wharfage_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`wharfage_schedule`(`wharfage_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ADD CONSTRAINT `fk_booking_slot_reservation_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ADD CONSTRAINT `fk_booking_pre_arrival_port_tariff_id` FOREIGN KEY (`port_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_tariff`(`port_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`amendment` ADD CONSTRAINT `fk_booking_amendment_exception_id` FOREIGN KEY (`exception_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`exception`(`exception_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_storage_tariff_id` FOREIGN KEY (`storage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`storage_tariff`(`storage_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ADD CONSTRAINT `fk_booking_voyage_nomination_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_anchorage_booking` ADD CONSTRAINT `fk_booking_booking_anchorage_booking_port_dues_schedule_id` FOREIGN KEY (`port_dues_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_dues_schedule`(`port_dues_schedule_id`);

-- ========= booking --> vessel (15 constraint(s)) =========
-- Requires: booking schema, vessel schema
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ADD CONSTRAINT `fk_booking_call_booking_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_berth_reservation` ADD CONSTRAINT `fk_booking_booking_berth_reservation_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ADD CONSTRAINT `fk_booking_slot_reservation_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ADD CONSTRAINT `fk_booking_pre_arrival_agent_appointment_id` FOREIGN KEY (`agent_appointment_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`agent_appointment`(`agent_appointment_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ADD CONSTRAINT `fk_booking_pre_arrival_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ADD CONSTRAINT `fk_booking_pre_arrival_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ADD CONSTRAINT `fk_booking_pre_arrival_voyage_id` FOREIGN KEY (`voyage_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`voyage`(`voyage_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ADD CONSTRAINT `fk_booking_voyage_nomination_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ADD CONSTRAINT `fk_booking_voyage_nomination_voyage_id` FOREIGN KEY (`voyage_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`voyage`(`voyage_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_anchorage_booking` ADD CONSTRAINT `fk_booking_booking_anchorage_booking_agent_appointment_id` FOREIGN KEY (`agent_appointment_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`agent_appointment`(`agent_appointment_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_anchorage_booking` ADD CONSTRAINT `fk_booking_booking_anchorage_booking_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_anchorage_booking` ADD CONSTRAINT `fk_booking_booking_anchorage_booking_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`confirmation` ADD CONSTRAINT `fk_booking_confirmation_agent_appointment_id` FOREIGN KEY (`agent_appointment_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`agent_appointment`(`agent_appointment_id`);

-- ========= booking --> workforce (9 constraint(s)) =========
-- Requires: booking schema, workforce schema
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ADD CONSTRAINT `fk_booking_booking_service_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_berth_reservation` ADD CONSTRAINT `fk_booking_booking_berth_reservation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`amendment` ADD CONSTRAINT `fk_booking_amendment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ADD CONSTRAINT `fk_booking_voyage_nomination_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ADD CONSTRAINT `fk_booking_service_requirement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_anchorage_booking` ADD CONSTRAINT `fk_booking_booking_anchorage_booking_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`resource_allocation` ADD CONSTRAINT `fk_booking_resource_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`confirmation` ADD CONSTRAINT `fk_booking_confirmation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`confirmation` ADD CONSTRAINT `fk_booking_confirmation_confirmation_employee_id` FOREIGN KEY (`confirmation_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= cargo --> asset (3 constraint(s)) =========
-- Requires: cargo schema, asset schema
ALTER TABLE `shipping_ports_ecm`.`cargo`.`move` ADD CONSTRAINT `fk_cargo_move_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`verified_gross_mass` ADD CONSTRAINT `fk_cargo_verified_gross_mass_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`damage_claim` ADD CONSTRAINT `fk_cargo_damage_claim_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);

-- ========= cargo --> billing (11 constraint(s)) =========
-- Requires: cargo schema, billing schema
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container` ADD CONSTRAINT `fk_cargo_container_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`bill_of_lading` ADD CONSTRAINT `fk_cargo_bill_of_lading_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_cargo_dangerous_goods_declaration_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`delivery_order` ADD CONSTRAINT `fk_cargo_delivery_order_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`demurrage_detention` ADD CONSTRAINT `fk_cargo_demurrage_detention_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`lcl_consolidation` ADD CONSTRAINT `fk_cargo_lcl_consolidation_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`verified_gross_mass` ADD CONSTRAINT `fk_cargo_verified_gross_mass_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container_surcharge_application` ADD CONSTRAINT `fk_cargo_container_surcharge_application_billing_cycle_id` FOREIGN KEY (`billing_cycle_id`) REFERENCES `shipping_ports_ecm`.`billing`.`billing_cycle`(`billing_cycle_id`);

-- ========= cargo --> booking (12 constraint(s)) =========
-- Requires: cargo schema, booking schema
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container` ADD CONSTRAINT `fk_cargo_container_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`bill_of_lading` ADD CONSTRAINT `fk_cargo_bill_of_lading_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`stowage_plan` ADD CONSTRAINT `fk_cargo_stowage_plan_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_cargo_dangerous_goods_declaration_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`delivery_order` ADD CONSTRAINT `fk_cargo_delivery_order_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`demurrage_detention` ADD CONSTRAINT `fk_cargo_demurrage_detention_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`lcl_consolidation` ADD CONSTRAINT `fk_cargo_lcl_consolidation_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`verified_gross_mass` ADD CONSTRAINT `fk_cargo_verified_gross_mass_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`damage_claim` ADD CONSTRAINT `fk_cargo_damage_claim_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);

-- ========= cargo --> compliance (15 constraint(s)) =========
-- Requires: cargo schema, compliance schema
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_customs_broker_id` FOREIGN KEY (`customs_broker_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_broker`(`customs_broker_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_trade_restriction_id` FOREIGN KEY (`trade_restriction_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`trade_restriction`(`trade_restriction_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container` ADD CONSTRAINT `fk_cargo_container_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`manifest_line` ADD CONSTRAINT `fk_cargo_manifest_line_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`hs_code`(`hs_code_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`move` ADD CONSTRAINT `fk_cargo_move_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_cargo_dangerous_goods_declaration_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`hs_code`(`hs_code_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_cargo_dangerous_goods_declaration_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_cargo_dangerous_goods_declaration_trade_restriction_id` FOREIGN KEY (`trade_restriction_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`trade_restriction`(`trade_restriction_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`delivery_order` ADD CONSTRAINT `fk_cargo_delivery_order_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`delivery_order` ADD CONSTRAINT `fk_cargo_delivery_order_import_export_permit_id` FOREIGN KEY (`import_export_permit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`import_export_permit`(`import_export_permit_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`demurrage_detention` ADD CONSTRAINT `fk_cargo_demurrage_detention_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`lcl_consolidation` ADD CONSTRAINT `fk_cargo_lcl_consolidation_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`cargo_document` ADD CONSTRAINT `fk_cargo_cargo_document_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`hs_code`(`hs_code_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`damage_claim` ADD CONSTRAINT `fk_cargo_damage_claim_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`violation`(`violation_id`);

-- ========= cargo --> contract (5 constraint(s)) =========
-- Requires: cargo schema, contract schema
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`delivery_order` ADD CONSTRAINT `fk_cargo_delivery_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`lcl_consolidation` ADD CONSTRAINT `fk_cargo_lcl_consolidation_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`damage_claim` ADD CONSTRAINT `fk_cargo_damage_claim_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= cargo --> customer (11 constraint(s)) =========
-- Requires: cargo schema, customer schema
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_shipment_notify_party_port_community_participant_id` FOREIGN KEY (`shipment_notify_party_port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_shipment_port_community_participant_id` FOREIGN KEY (`shipment_port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`stowage_position` ADD CONSTRAINT `fk_cargo_stowage_position_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_cargo_dangerous_goods_declaration_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`delivery_order` ADD CONSTRAINT `fk_cargo_delivery_order_contact_person_id` FOREIGN KEY (`contact_person_id`) REFERENCES `shipping_ports_ecm`.`customer`.`contact_person`(`contact_person_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`delivery_order` ADD CONSTRAINT `fk_cargo_delivery_order_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`lcl_consolidation` ADD CONSTRAINT `fk_cargo_lcl_consolidation_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`cargo_document` ADD CONSTRAINT `fk_cargo_cargo_document_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`verified_gross_mass` ADD CONSTRAINT `fk_cargo_verified_gross_mass_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`damage_claim` ADD CONSTRAINT `fk_cargo_damage_claim_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);

-- ========= cargo --> finance (6 constraint(s)) =========
-- Requires: cargo schema, finance schema
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `shipping_ports_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`lcl_consolidation` ADD CONSTRAINT `fk_cargo_lcl_consolidation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`damage_claim` ADD CONSTRAINT `fk_cargo_damage_claim_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`damage_claim` ADD CONSTRAINT `fk_cargo_damage_claim_provision_id` FOREIGN KEY (`provision_id`) REFERENCES `shipping_ports_ecm`.`finance`.`provision`(`provision_id`);

-- ========= cargo --> infrastructure (14 constraint(s)) =========
-- Requires: cargo schema, infrastructure schema
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container` ADD CONSTRAINT `fk_cargo_container_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container` ADD CONSTRAINT `fk_cargo_container_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`move` ADD CONSTRAINT `fk_cargo_move_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`move` ADD CONSTRAINT `fk_cargo_move_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`move` ADD CONSTRAINT `fk_cargo_move_port_gate_id` FOREIGN KEY (`port_gate_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port_gate`(`port_gate_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`stowage_position` ADD CONSTRAINT `fk_cargo_stowage_position_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`demurrage_detention` ADD CONSTRAINT `fk_cargo_demurrage_detention_terminal_terminal_zone_id` FOREIGN KEY (`terminal_terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`demurrage_detention` ADD CONSTRAINT `fk_cargo_demurrage_detention_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`lcl_consolidation` ADD CONSTRAINT `fk_cargo_lcl_consolidation_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`verified_gross_mass` ADD CONSTRAINT `fk_cargo_verified_gross_mass_port_gate_id` FOREIGN KEY (`port_gate_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port_gate`(`port_gate_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`verified_gross_mass` ADD CONSTRAINT `fk_cargo_verified_gross_mass_weighing_station_id` FOREIGN KEY (`weighing_station_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`weighing_station`(`weighing_station_id`);

-- ========= cargo --> intermodal (3 constraint(s)) =========
-- Requires: cargo schema, intermodal schema
ALTER TABLE `shipping_ports_ecm`.`cargo`.`cargo_rail_wagon_load` ADD CONSTRAINT `fk_cargo_cargo_rail_wagon_load_rail_visit_id` FOREIGN KEY (`rail_visit_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`rail_visit`(`rail_visit_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`cargo_rail_wagon_load` ADD CONSTRAINT `fk_cargo_cargo_rail_wagon_load_intermodal_rail_wagon_load_id` FOREIGN KEY (`intermodal_rail_wagon_load_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`intermodal_rail_wagon_load`(`intermodal_rail_wagon_load_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container_gate_transaction` ADD CONSTRAINT `fk_cargo_container_gate_transaction_truck_visit_id` FOREIGN KEY (`truck_visit_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`truck_visit`(`truck_visit_id`);

-- ========= cargo --> masterdata (19 constraint(s)) =========
-- Requires: cargo schema, masterdata schema
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_packaging_type_id` FOREIGN KEY (`packaging_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`packaging_type`(`packaging_type_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container` ADD CONSTRAINT `fk_cargo_container_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container` ADD CONSTRAINT `fk_cargo_container_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`container_type`(`container_type_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`bill_of_lading` ADD CONSTRAINT `fk_cargo_bill_of_lading_packaging_type_id` FOREIGN KEY (`packaging_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`packaging_type`(`packaging_type_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`manifest_line` ADD CONSTRAINT `fk_cargo_manifest_line_packaging_type_id` FOREIGN KEY (`packaging_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`packaging_type`(`packaging_type_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`move` ADD CONSTRAINT `fk_cargo_move_equipment_type_id` FOREIGN KEY (`equipment_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`equipment_type`(`equipment_type_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`stowage_plan` ADD CONSTRAINT `fk_cargo_stowage_plan_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`stowage_position` ADD CONSTRAINT `fk_cargo_stowage_position_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_cargo_dangerous_goods_declaration_packaging_type_id` FOREIGN KEY (`packaging_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`packaging_type`(`packaging_type_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container_preadvice` ADD CONSTRAINT `fk_cargo_container_preadvice_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`demurrage_detention` ADD CONSTRAINT `fk_cargo_demurrage_detention_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`lcl_consolidation` ADD CONSTRAINT `fk_cargo_lcl_consolidation_packaging_type_id` FOREIGN KEY (`packaging_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`packaging_type`(`packaging_type_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`lcl_consolidation` ADD CONSTRAINT `fk_cargo_lcl_consolidation_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`cargo_document` ADD CONSTRAINT `fk_cargo_cargo_document_packaging_type_id` FOREIGN KEY (`packaging_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`packaging_type`(`packaging_type_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`verified_gross_mass` ADD CONSTRAINT `fk_cargo_verified_gross_mass_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);

-- ========= cargo --> safety (7 constraint(s)) =========
-- Requires: cargo schema, safety schema
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container` ADD CONSTRAINT `fk_cargo_container_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `shipping_ports_ecm`.`safety`.`inspection`(`inspection_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `shipping_ports_ecm`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`move` ADD CONSTRAINT `fk_cargo_move_ohs_incident_id` FOREIGN KEY (`ohs_incident_id`) REFERENCES `shipping_ports_ecm`.`safety`.`ohs_incident`(`ohs_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`move` ADD CONSTRAINT `fk_cargo_move_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `shipping_ports_ecm`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_cargo_dangerous_goods_declaration_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `shipping_ports_ecm`.`safety`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_cargo_dangerous_goods_declaration_hazard_register_id` FOREIGN KEY (`hazard_register_id`) REFERENCES `shipping_ports_ecm`.`safety`.`hazard_register`(`hazard_register_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_cargo_dangerous_goods_declaration_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `shipping_ports_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);

-- ========= cargo --> security (24 constraint(s)) =========
-- Requires: cargo schema, security schema
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_cyber_incident_id` FOREIGN KEY (`cyber_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`cyber_incident`(`cyber_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_screening_record_id` FOREIGN KEY (`screening_record_id`) REFERENCES `shipping_ports_ecm`.`security`.`screening_record`(`screening_record_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_threat_assessment_id` FOREIGN KEY (`threat_assessment_id`) REFERENCES `shipping_ports_ecm`.`security`.`threat_assessment`(`threat_assessment_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container` ADD CONSTRAINT `fk_cargo_container_access_event_id` FOREIGN KEY (`access_event_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_event`(`access_event_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container` ADD CONSTRAINT `fk_cargo_container_screening_record_id` FOREIGN KEY (`screening_record_id`) REFERENCES `shipping_ports_ecm`.`security`.`screening_record`(`screening_record_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container` ADD CONSTRAINT `fk_cargo_container_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container` ADD CONSTRAINT `fk_cargo_container_stowaway_case_id` FOREIGN KEY (`stowaway_case_id`) REFERENCES `shipping_ports_ecm`.`security`.`stowaway_case`(`stowaway_case_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`bill_of_lading` ADD CONSTRAINT `fk_cargo_bill_of_lading_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_dos_record_id` FOREIGN KEY (`dos_record_id`) REFERENCES `shipping_ports_ecm`.`security`.`dos_record`(`dos_record_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_dos_record_id` FOREIGN KEY (`dos_record_id`) REFERENCES `shipping_ports_ecm`.`security`.`dos_record`(`dos_record_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`move` ADD CONSTRAINT `fk_cargo_move_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`stowage_plan` ADD CONSTRAINT `fk_cargo_stowage_plan_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_cargo_dangerous_goods_declaration_screening_record_id` FOREIGN KEY (`screening_record_id`) REFERENCES `shipping_ports_ecm`.`security`.`screening_record`(`screening_record_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_cargo_dangerous_goods_declaration_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_cargo_dangerous_goods_declaration_threat_assessment_id` FOREIGN KEY (`threat_assessment_id`) REFERENCES `shipping_ports_ecm`.`security`.`threat_assessment`(`threat_assessment_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container_preadvice` ADD CONSTRAINT `fk_cargo_container_preadvice_screening_record_id` FOREIGN KEY (`screening_record_id`) REFERENCES `shipping_ports_ecm`.`security`.`screening_record`(`screening_record_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`delivery_order` ADD CONSTRAINT `fk_cargo_delivery_order_access_event_id` FOREIGN KEY (`access_event_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_event`(`access_event_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`delivery_order` ADD CONSTRAINT `fk_cargo_delivery_order_visitor_log_id` FOREIGN KEY (`visitor_log_id`) REFERENCES `shipping_ports_ecm`.`security`.`visitor_log`(`visitor_log_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`lcl_consolidation` ADD CONSTRAINT `fk_cargo_lcl_consolidation_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`verified_gross_mass` ADD CONSTRAINT `fk_cargo_verified_gross_mass_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`damage_claim` ADD CONSTRAINT `fk_cargo_damage_claim_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);

-- ========= cargo --> tariff (13 constraint(s)) =========
-- Requires: cargo schema, tariff schema
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_port_tariff_id` FOREIGN KEY (`port_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_tariff`(`port_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container` ADD CONSTRAINT `fk_cargo_container_storage_tariff_id` FOREIGN KEY (`storage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`storage_tariff`(`storage_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`bill_of_lading` ADD CONSTRAINT `fk_cargo_bill_of_lading_wharfage_schedule_id` FOREIGN KEY (`wharfage_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`wharfage_schedule`(`wharfage_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_thc_schedule_id` FOREIGN KEY (`thc_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`thc_schedule`(`thc_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`move` ADD CONSTRAINT `fk_cargo_move_item_id` FOREIGN KEY (`item_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`item`(`item_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`delivery_order` ADD CONSTRAINT `fk_cargo_delivery_order_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`demurrage_detention` ADD CONSTRAINT `fk_cargo_demurrage_detention_demurrage_schedule_id` FOREIGN KEY (`demurrage_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`demurrage_schedule`(`demurrage_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`demurrage_detention` ADD CONSTRAINT `fk_cargo_demurrage_detention_detention_schedule_id` FOREIGN KEY (`detention_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`detention_schedule`(`detention_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`demurrage_detention` ADD CONSTRAINT `fk_cargo_demurrage_detention_port_tariff_id` FOREIGN KEY (`port_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_tariff`(`port_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`lcl_consolidation` ADD CONSTRAINT `fk_cargo_lcl_consolidation_thc_schedule_id` FOREIGN KEY (`thc_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`thc_schedule`(`thc_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment_tariff_exception` ADD CONSTRAINT `fk_cargo_shipment_tariff_exception_exception_id` FOREIGN KEY (`exception_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`exception`(`exception_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`bol_discount_application` ADD CONSTRAINT `fk_cargo_bol_discount_application_discount_scheme_id` FOREIGN KEY (`discount_scheme_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`discount_scheme`(`discount_scheme_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container_surcharge_application` ADD CONSTRAINT `fk_cargo_container_surcharge_application_surcharge_rule_id` FOREIGN KEY (`surcharge_rule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`surcharge_rule`(`surcharge_rule_id`);

-- ========= cargo --> terminal (1 constraint(s)) =========
-- Requires: cargo schema, terminal schema
ALTER TABLE `shipping_ports_ecm`.`cargo`.`move` ADD CONSTRAINT `fk_cargo_move_terminal_equipment_id` FOREIGN KEY (`terminal_equipment_id`) REFERENCES `shipping_ports_ecm`.`terminal`.`terminal_equipment`(`terminal_equipment_id`);

-- ========= cargo --> vessel (18 constraint(s)) =========
-- Requires: cargo schema, vessel schema
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_shipment_vessel_call_id` FOREIGN KEY (`shipment_vessel_call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_agent_appointment_id` FOREIGN KEY (`agent_appointment_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`agent_appointment`(`agent_appointment_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`move` ADD CONSTRAINT `fk_cargo_move_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`stowage_plan` ADD CONSTRAINT `fk_cargo_stowage_plan_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`stowage_plan` ADD CONSTRAINT `fk_cargo_stowage_plan_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`stowage_position` ADD CONSTRAINT `fk_cargo_stowage_position_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`stowage_position` ADD CONSTRAINT `fk_cargo_stowage_position_voyage_id` FOREIGN KEY (`voyage_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`voyage`(`voyage_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_cargo_dangerous_goods_declaration_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container_preadvice` ADD CONSTRAINT `fk_cargo_container_preadvice_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`delivery_order` ADD CONSTRAINT `fk_cargo_delivery_order_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`demurrage_detention` ADD CONSTRAINT `fk_cargo_demurrage_detention_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`lcl_consolidation` ADD CONSTRAINT `fk_cargo_lcl_consolidation_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`lcl_consolidation` ADD CONSTRAINT `fk_cargo_lcl_consolidation_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`verified_gross_mass` ADD CONSTRAINT `fk_cargo_verified_gross_mass_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`damage_claim` ADD CONSTRAINT `fk_cargo_damage_claim_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);

-- ========= cargo --> workforce (19 constraint(s)) =========
-- Requires: cargo schema, workforce schema
ALTER TABLE `shipping_ports_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_manifest_last_modified_by_user_employee_id` FOREIGN KEY (`manifest_last_modified_by_user_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_gang_id` FOREIGN KEY (`gang_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`gang`(`gang_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`move` ADD CONSTRAINT `fk_cargo_move_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`move` ADD CONSTRAINT `fk_cargo_move_gang_id` FOREIGN KEY (`gang_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`gang`(`gang_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`move` ADD CONSTRAINT `fk_cargo_move_shift_pattern_id` FOREIGN KEY (`shift_pattern_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`shift_pattern`(`shift_pattern_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`stowage_plan` ADD CONSTRAINT `fk_cargo_stowage_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`stowage_plan` ADD CONSTRAINT `fk_cargo_stowage_plan_primary_stowage_employee_id` FOREIGN KEY (`primary_stowage_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_cargo_dangerous_goods_declaration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`delivery_order` ADD CONSTRAINT `fk_cargo_delivery_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`lcl_consolidation` ADD CONSTRAINT `fk_cargo_lcl_consolidation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`cargo_document` ADD CONSTRAINT `fk_cargo_cargo_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`verified_gross_mass` ADD CONSTRAINT `fk_cargo_verified_gross_mass_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`damage_claim` ADD CONSTRAINT `fk_cargo_damage_claim_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment_tariff_exception` ADD CONSTRAINT `fk_cargo_shipment_tariff_exception_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`cargo_rail_wagon_load` ADD CONSTRAINT `fk_cargo_cargo_rail_wagon_load_discharge_operator_employee_id` FOREIGN KEY (`discharge_operator_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`cargo_rail_wagon_load` ADD CONSTRAINT `fk_cargo_cargo_rail_wagon_load_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container_surcharge_application` ADD CONSTRAINT `fk_cargo_container_surcharge_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= compliance --> cargo (6 constraint(s)) =========
-- Requires: compliance schema, cargo schema
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ADD CONSTRAINT `fk_compliance_customs_declaration_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ADD CONSTRAINT `fk_compliance_trade_document_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ADD CONSTRAINT `fk_compliance_trade_document_container_id` FOREIGN KEY (`container_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`container`(`container_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ADD CONSTRAINT `fk_compliance_trade_document_dangerous_goods_declaration_id` FOREIGN KEY (`dangerous_goods_declaration_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration`(`dangerous_goods_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ADD CONSTRAINT `fk_compliance_trade_document_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`manifest`(`manifest_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ADD CONSTRAINT `fk_compliance_trade_document_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`shipment`(`shipment_id`);

-- ========= compliance --> customer (1 constraint(s)) =========
-- Requires: compliance schema, customer schema
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ADD CONSTRAINT `fk_compliance_customs_broker_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);

-- ========= compliance --> finance (11 constraint(s)) =========
-- Requires: compliance schema, finance schema
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ADD CONSTRAINT `fk_compliance_customs_declaration_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ADD CONSTRAINT `fk_compliance_customs_declaration_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `shipping_ports_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ADD CONSTRAINT `fk_compliance_sanctions_screening_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ADD CONSTRAINT `fk_compliance_isps_facility_record_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ADD CONSTRAINT `fk_compliance_isps_facility_record_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `shipping_ports_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ADD CONSTRAINT `fk_compliance_customs_hold_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ADD CONSTRAINT `fk_compliance_marpol_record_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ADD CONSTRAINT `fk_compliance_marpol_record_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `shipping_ports_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`compliance_audit` ADD CONSTRAINT `fk_compliance_compliance_audit_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`compliance_audit` ADD CONSTRAINT `fk_compliance_compliance_audit_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);

-- ========= compliance --> infrastructure (1 constraint(s)) =========
-- Requires: compliance schema, infrastructure schema
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ADD CONSTRAINT `fk_compliance_isps_facility_record_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);

-- ========= compliance --> masterdata (20 constraint(s)) =========
-- Requires: compliance schema, masterdata schema
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ADD CONSTRAINT `fk_compliance_customs_declaration_country_id` FOREIGN KEY (`country_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ADD CONSTRAINT `fk_compliance_customs_declaration_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ADD CONSTRAINT `fk_compliance_customs_declaration_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ADD CONSTRAINT `fk_compliance_trade_document_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ADD CONSTRAINT `fk_compliance_trade_document_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ADD CONSTRAINT `fk_compliance_sanctions_screening_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ADD CONSTRAINT `fk_compliance_isps_facility_record_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ADD CONSTRAINT `fk_compliance_import_export_permit_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ADD CONSTRAINT `fk_compliance_import_export_permit_country_id` FOREIGN KEY (`country_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ADD CONSTRAINT `fk_compliance_customs_hold_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ADD CONSTRAINT `fk_compliance_marpol_record_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ADD CONSTRAINT `fk_compliance_marpol_record_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ADD CONSTRAINT `fk_compliance_trade_restriction_country_id` FOREIGN KEY (`country_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ADD CONSTRAINT `fk_compliance_trade_restriction_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ADD CONSTRAINT `fk_compliance_customs_broker_edi_partner_id` FOREIGN KEY (`edi_partner_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`edi_partner`(`edi_partner_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ADD CONSTRAINT `fk_compliance_customs_broker_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`compliance_audit` ADD CONSTRAINT `fk_compliance_compliance_audit_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`compliance_audit` ADD CONSTRAINT `fk_compliance_compliance_audit_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);

-- ========= compliance --> procurement (10 constraint(s)) =========
-- Requires: compliance schema, procurement schema
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ADD CONSTRAINT `fk_compliance_customs_declaration_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ADD CONSTRAINT `fk_compliance_customs_declaration_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ADD CONSTRAINT `fk_compliance_trade_document_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ADD CONSTRAINT `fk_compliance_trade_document_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ADD CONSTRAINT `fk_compliance_sanctions_screening_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ADD CONSTRAINT `fk_compliance_import_export_permit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ADD CONSTRAINT `fk_compliance_customs_hold_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ADD CONSTRAINT `fk_compliance_customs_broker_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= compliance --> security (6 constraint(s)) =========
-- Requires: compliance schema, security schema
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ADD CONSTRAINT `fk_compliance_customs_declaration_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ADD CONSTRAINT `fk_compliance_sanctions_screening_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ADD CONSTRAINT `fk_compliance_sanctions_screening_watchlist_entry_id` FOREIGN KEY (`watchlist_entry_id`) REFERENCES `shipping_ports_ecm`.`security`.`watchlist_entry`(`watchlist_entry_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ADD CONSTRAINT `fk_compliance_customs_hold_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`declaration_screening` ADD CONSTRAINT `fk_compliance_declaration_screening_screening_record_id` FOREIGN KEY (`screening_record_id`) REFERENCES `shipping_ports_ecm`.`security`.`screening_record`(`screening_record_id`);

-- ========= compliance --> vessel (3 constraint(s)) =========
-- Requires: compliance schema, vessel schema
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ADD CONSTRAINT `fk_compliance_customs_declaration_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ADD CONSTRAINT `fk_compliance_trade_document_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ADD CONSTRAINT `fk_compliance_sanctions_screening_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);

-- ========= compliance --> workforce (11 constraint(s)) =========
-- Requires: compliance schema, workforce schema
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ADD CONSTRAINT `fk_compliance_customs_declaration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ADD CONSTRAINT `fk_compliance_trade_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ADD CONSTRAINT `fk_compliance_sanctions_screening_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ADD CONSTRAINT `fk_compliance_isps_facility_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ADD CONSTRAINT `fk_compliance_import_export_permit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ADD CONSTRAINT `fk_compliance_customs_hold_position_id` FOREIGN KEY (`position_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ADD CONSTRAINT `fk_compliance_customs_hold_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ADD CONSTRAINT `fk_compliance_marpol_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`compliance_audit` ADD CONSTRAINT `fk_compliance_compliance_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`declaration_screening` ADD CONSTRAINT `fk_compliance_declaration_screening_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= contract --> billing (3 constraint(s)) =========
-- Requires: contract schema, billing schema
ALTER TABLE `shipping_ports_ecm`.`contract`.`sla_measurement` ADD CONSTRAINT `fk_contract_sla_measurement_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`penalty_assessment` ADD CONSTRAINT `fk_contract_penalty_assessment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`dispute_record` ADD CONSTRAINT `fk_contract_dispute_record_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= contract --> compliance (9 constraint(s)) =========
-- Requires: contract schema, compliance schema
ALTER TABLE `shipping_ports_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_customs_broker_id` FOREIGN KEY (`customs_broker_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_broker`(`customs_broker_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_trade_restriction_id` FOREIGN KEY (`trade_restriction_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`trade_restriction`(`trade_restriction_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`service_scope` ADD CONSTRAINT `fk_contract_service_scope_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`hs_code`(`hs_code_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`sla_measurement` ADD CONSTRAINT `fk_contract_sla_measurement_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`sla_breach` ADD CONSTRAINT `fk_contract_sla_breach_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`penalty_assessment` ADD CONSTRAINT `fk_contract_penalty_assessment_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`dispute_record` ADD CONSTRAINT `fk_contract_dispute_record_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`dispute_record` ADD CONSTRAINT `fk_contract_dispute_record_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`guarantee_bond` ADD CONSTRAINT `fk_contract_guarantee_bond_customs_broker_id` FOREIGN KEY (`customs_broker_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_broker`(`customs_broker_id`);

-- ========= contract --> customer (10 constraint(s)) =========
-- Requires: contract schema, customer schema
ALTER TABLE `shipping_ports_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `shipping_ports_ecm`.`customer`.`sla_profile`(`sla_profile_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`agreement_party` ADD CONSTRAINT `fk_contract_agreement_party_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`sla_measurement` ADD CONSTRAINT `fk_contract_sla_measurement_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`sla_breach` ADD CONSTRAINT `fk_contract_sla_breach_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`volume_commitment` ADD CONSTRAINT `fk_contract_volume_commitment_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`penalty_assessment` ADD CONSTRAINT `fk_contract_penalty_assessment_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`penalty_assessment` ADD CONSTRAINT `fk_contract_penalty_assessment_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `shipping_ports_ecm`.`customer`.`sla_profile`(`sla_profile_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`dispute_record` ADD CONSTRAINT `fk_contract_dispute_record_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`dispute_record` ADD CONSTRAINT `fk_contract_dispute_record_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `shipping_ports_ecm`.`customer`.`sla_profile`(`sla_profile_id`);

-- ========= contract --> finance (12 constraint(s)) =========
-- Requires: contract schema, finance schema
ALTER TABLE `shipping_ports_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`service_scope` ADD CONSTRAINT `fk_contract_service_scope_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`service_scope` ADD CONSTRAINT `fk_contract_service_scope_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`sla_measurement` ADD CONSTRAINT `fk_contract_sla_measurement_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`rate_schedule` ADD CONSTRAINT `fk_contract_rate_schedule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`volume_commitment` ADD CONSTRAINT `fk_contract_volume_commitment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`pil_arrangement` ADD CONSTRAINT `fk_contract_pil_arrangement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`penalty_assessment` ADD CONSTRAINT `fk_contract_penalty_assessment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`penalty_assessment` ADD CONSTRAINT `fk_contract_penalty_assessment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`penalty_assessment` ADD CONSTRAINT `fk_contract_penalty_assessment_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`guarantee_bond` ADD CONSTRAINT `fk_contract_guarantee_bond_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= contract --> masterdata (14 constraint(s)) =========
-- Requires: contract schema, masterdata schema
ALTER TABLE `shipping_ports_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_equipment_type_id` FOREIGN KEY (`equipment_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`equipment_type`(`equipment_type_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`service_scope` ADD CONSTRAINT `fk_contract_service_scope_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`service_scope` ADD CONSTRAINT `fk_contract_service_scope_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`container_type`(`container_type_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`service_scope` ADD CONSTRAINT `fk_contract_service_scope_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`service_scope` ADD CONSTRAINT `fk_contract_service_scope_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`sla_measurement` ADD CONSTRAINT `fk_contract_sla_measurement_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`rate_schedule` ADD CONSTRAINT `fk_contract_rate_schedule_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`rate_schedule` ADD CONSTRAINT `fk_contract_rate_schedule_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`container_type`(`container_type_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`rate_schedule` ADD CONSTRAINT `fk_contract_rate_schedule_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`rate_schedule` ADD CONSTRAINT `fk_contract_rate_schedule_service_code_id` FOREIGN KEY (`service_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`service_code`(`service_code_id`);

-- ========= contract --> procurement (7 constraint(s)) =========
-- Requires: contract schema, procurement schema
ALTER TABLE `shipping_ports_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`service_scope` ADD CONSTRAINT `fk_contract_service_scope_material_group_id` FOREIGN KEY (`material_group_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`material_group`(`material_group_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`rate_schedule` ADD CONSTRAINT `fk_contract_rate_schedule_material_group_id` FOREIGN KEY (`material_group_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`material_group`(`material_group_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`penalty_assessment` ADD CONSTRAINT `fk_contract_penalty_assessment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`dispute_record` ADD CONSTRAINT `fk_contract_dispute_record_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`dispute_record` ADD CONSTRAINT `fk_contract_dispute_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= contract --> security (4 constraint(s)) =========
-- Requires: contract schema, security schema
ALTER TABLE `shipping_ports_ecm`.`contract`.`agreement_party` ADD CONSTRAINT `fk_contract_agreement_party_access_credential_id` FOREIGN KEY (`access_credential_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_credential`(`access_credential_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`sla_measurement` ADD CONSTRAINT `fk_contract_sla_measurement_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`contract_document` ADD CONSTRAINT `fk_contract_contract_document_facility_security_plan_id` FOREIGN KEY (`facility_security_plan_id`) REFERENCES `shipping_ports_ecm`.`security`.`facility_security_plan`(`facility_security_plan_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`dispute_record` ADD CONSTRAINT `fk_contract_dispute_record_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);

-- ========= contract --> tariff (3 constraint(s)) =========
-- Requires: contract schema, tariff schema
ALTER TABLE `shipping_ports_ecm`.`contract`.`sla_definition` ADD CONSTRAINT `fk_contract_sla_definition_sla_rate_card_id` FOREIGN KEY (`sla_rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`sla_rate_card`(`sla_rate_card_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`rate_schedule` ADD CONSTRAINT `fk_contract_rate_schedule_port_tariff_id` FOREIGN KEY (`port_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_tariff`(`port_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`penalty_assessment` ADD CONSTRAINT `fk_contract_penalty_assessment_item_id` FOREIGN KEY (`item_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`item`(`item_id`);

-- ========= contract --> terminal (2 constraint(s)) =========
-- Requires: contract schema, terminal schema
ALTER TABLE `shipping_ports_ecm`.`contract`.`sla_measurement` ADD CONSTRAINT `fk_contract_sla_measurement_terminal_berth_allocation_id` FOREIGN KEY (`terminal_berth_allocation_id`) REFERENCES `shipping_ports_ecm`.`terminal`.`terminal_berth_allocation`(`terminal_berth_allocation_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`sla_breach` ADD CONSTRAINT `fk_contract_sla_breach_terminal_berth_allocation_id` FOREIGN KEY (`terminal_berth_allocation_id`) REFERENCES `shipping_ports_ecm`.`terminal`.`terminal_berth_allocation`(`terminal_berth_allocation_id`);

-- ========= contract --> vessel (2 constraint(s)) =========
-- Requires: contract schema, vessel schema
ALTER TABLE `shipping_ports_ecm`.`contract`.`sla_measurement` ADD CONSTRAINT `fk_contract_sla_measurement_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`penalty_assessment` ADD CONSTRAINT `fk_contract_penalty_assessment_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);

-- ========= contract --> workforce (13 constraint(s)) =========
-- Requires: contract schema, workforce schema
ALTER TABLE `shipping_ports_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`agreement_version` ADD CONSTRAINT `fk_contract_agreement_version_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`service_scope` ADD CONSTRAINT `fk_contract_service_scope_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`sla_definition` ADD CONSTRAINT `fk_contract_sla_definition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`sla_measurement` ADD CONSTRAINT `fk_contract_sla_measurement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`rate_schedule` ADD CONSTRAINT `fk_contract_rate_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`volume_commitment` ADD CONSTRAINT `fk_contract_volume_commitment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`pil_arrangement` ADD CONSTRAINT `fk_contract_pil_arrangement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`contract_document` ADD CONSTRAINT `fk_contract_contract_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`penalty_clause` ADD CONSTRAINT `fk_contract_penalty_clause_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`penalty_assessment` ADD CONSTRAINT `fk_contract_penalty_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`dispute_record` ADD CONSTRAINT `fk_contract_dispute_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`contract`.`guarantee_bond` ADD CONSTRAINT `fk_contract_guarantee_bond_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= customer --> cargo (4 constraint(s)) =========
-- Requires: customer schema, cargo schema
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_container_id` FOREIGN KEY (`container_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`container`(`container_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`communication_log` ADD CONSTRAINT `fk_customer_communication_log_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`communication_log` ADD CONSTRAINT `fk_customer_communication_log_container_id` FOREIGN KEY (`container_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`container`(`container_id`);

-- ========= customer --> compliance (12 constraint(s)) =========
-- Requires: customer schema, compliance schema
ALTER TABLE `shipping_ports_ecm`.`customer`.`accreditation` ADD CONSTRAINT `fk_customer_accreditation_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`hs_code`(`hs_code_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`sla_performance` ADD CONSTRAINT `fk_customer_sla_performance_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`communication_log` ADD CONSTRAINT `fk_customer_communication_log_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`communication_log` ADD CONSTRAINT `fk_customer_communication_log_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`onboarding_application` ADD CONSTRAINT `fk_customer_onboarding_application_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`participant_document` ADD CONSTRAINT `fk_customer_participant_document_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`hs_code`(`hs_code_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`participant_document` ADD CONSTRAINT `fk_customer_participant_document_trade_restriction_id` FOREIGN KEY (`trade_restriction_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`trade_restriction`(`trade_restriction_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`port_access_permit` ADD CONSTRAINT `fk_customer_port_access_permit_isps_facility_record_id` FOREIGN KEY (`isps_facility_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`isps_facility_record`(`isps_facility_record_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`participant_trade_exemption` ADD CONSTRAINT `fk_customer_participant_trade_exemption_trade_restriction_id` FOREIGN KEY (`trade_restriction_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`trade_restriction`(`trade_restriction_id`);

-- ========= customer --> contract (6 constraint(s)) =========
-- Requires: customer schema, contract schema
ALTER TABLE `shipping_ports_ecm`.`customer`.`sla_performance` ADD CONSTRAINT `fk_customer_sla_performance_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`sla_performance` ADD CONSTRAINT `fk_customer_sla_performance_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `shipping_ports_ecm`.`contract`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`relationship_manager` ADD CONSTRAINT `fk_customer_relationship_manager_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`participant_document` ADD CONSTRAINT `fk_customer_participant_document_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`edi_subscription` ADD CONSTRAINT `fk_customer_edi_subscription_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= customer --> finance (9 constraint(s)) =========
-- Requires: customer schema, finance schema
ALTER TABLE `shipping_ports_ecm`.`customer`.`participant_account` ADD CONSTRAINT `fk_customer_participant_account_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `shipping_ports_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`participant_account` ADD CONSTRAINT `fk_customer_participant_account_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`accreditation` ADD CONSTRAINT `fk_customer_accreditation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`sla_performance` ADD CONSTRAINT `fk_customer_sla_performance_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `shipping_ports_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`communication_log` ADD CONSTRAINT `fk_customer_communication_log_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`onboarding_application` ADD CONSTRAINT `fk_customer_onboarding_application_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);

-- ========= customer --> infrastructure (2 constraint(s)) =========
-- Requires: customer schema, infrastructure schema
ALTER TABLE `shipping_ports_ecm`.`customer`.`edi_subscription` ADD CONSTRAINT `fk_customer_edi_subscription_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`channel`(`channel_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`port_access_permit` ADD CONSTRAINT `fk_customer_port_access_permit_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`permit`(`permit_id`);

-- ========= customer --> masterdata (24 constraint(s)) =========
-- Requires: customer schema, masterdata schema
ALTER TABLE `shipping_ports_ecm`.`customer`.`port_community_participant` ADD CONSTRAINT `fk_customer_port_community_participant_country_id` FOREIGN KEY (`country_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`port_community_participant` ADD CONSTRAINT `fk_customer_port_community_participant_flag_state_id` FOREIGN KEY (`flag_state_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`flag_state`(`flag_state_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`participant_account` ADD CONSTRAINT `fk_customer_participant_account_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`accreditation` ADD CONSTRAINT `fk_customer_accreditation_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`accreditation` ADD CONSTRAINT `fk_customer_accreditation_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`sla_profile` ADD CONSTRAINT `fk_customer_sla_profile_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`sla_profile` ADD CONSTRAINT `fk_customer_sla_profile_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`sla_performance` ADD CONSTRAINT `fk_customer_sla_performance_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`sla_performance` ADD CONSTRAINT `fk_customer_sla_performance_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`communication_log` ADD CONSTRAINT `fk_customer_communication_log_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`communication_log` ADD CONSTRAINT `fk_customer_communication_log_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`onboarding_application` ADD CONSTRAINT `fk_customer_onboarding_application_country_id` FOREIGN KEY (`country_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`participant_document` ADD CONSTRAINT `fk_customer_participant_document_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`participant_document` ADD CONSTRAINT `fk_customer_participant_document_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`edi_subscription` ADD CONSTRAINT `fk_customer_edi_subscription_edi_partner_id` FOREIGN KEY (`edi_partner_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`edi_partner`(`edi_partner_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`edi_subscription` ADD CONSTRAINT `fk_customer_edi_subscription_receiver_edi_partner_id` FOREIGN KEY (`receiver_edi_partner_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`edi_partner`(`edi_partner_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`edi_subscription` ADD CONSTRAINT `fk_customer_edi_subscription_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`port_access_permit` ADD CONSTRAINT `fk_customer_port_access_permit_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`participant_service_agreement` ADD CONSTRAINT `fk_customer_participant_service_agreement_service_code_id` FOREIGN KEY (`service_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`service_code`(`service_code_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`location_access_authorization` ADD CONSTRAINT `fk_customer_location_access_authorization_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`commodity_handling_authorization` ADD CONSTRAINT `fk_customer_commodity_handling_authorization_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);

-- ========= customer --> procurement (2 constraint(s)) =========
-- Requires: customer schema, procurement schema
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`port_access_permit` ADD CONSTRAINT `fk_customer_port_access_permit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= customer --> safety (6 constraint(s)) =========
-- Requires: customer schema, safety schema
ALTER TABLE `shipping_ports_ecm`.`customer`.`accreditation` ADD CONSTRAINT `fk_customer_accreditation_contractor_safety_id` FOREIGN KEY (`contractor_safety_id`) REFERENCES `shipping_ports_ecm`.`safety`.`contractor_safety`(`contractor_safety_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`sla_performance` ADD CONSTRAINT `fk_customer_sla_performance_kpi_id` FOREIGN KEY (`kpi_id`) REFERENCES `shipping_ports_ecm`.`safety`.`kpi`(`kpi_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `shipping_ports_ecm`.`safety`.`inspection`(`inspection_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_ohs_incident_id` FOREIGN KEY (`ohs_incident_id`) REFERENCES `shipping_ports_ecm`.`safety`.`ohs_incident`(`ohs_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`communication_log` ADD CONSTRAINT `fk_customer_communication_log_ohs_incident_id` FOREIGN KEY (`ohs_incident_id`) REFERENCES `shipping_ports_ecm`.`safety`.`ohs_incident`(`ohs_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`port_access_permit` ADD CONSTRAINT `fk_customer_port_access_permit_contractor_safety_id` FOREIGN KEY (`contractor_safety_id`) REFERENCES `shipping_ports_ecm`.`safety`.`contractor_safety`(`contractor_safety_id`);

-- ========= customer --> security (5 constraint(s)) =========
-- Requires: customer schema, security schema
ALTER TABLE `shipping_ports_ecm`.`customer`.`accreditation` ADD CONSTRAINT `fk_customer_accreditation_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`onboarding_application` ADD CONSTRAINT `fk_customer_onboarding_application_personnel_id` FOREIGN KEY (`personnel_id`) REFERENCES `shipping_ports_ecm`.`security`.`personnel`(`personnel_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`participant_document` ADD CONSTRAINT `fk_customer_participant_document_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`port_access_permit` ADD CONSTRAINT `fk_customer_port_access_permit_access_point_id` FOREIGN KEY (`access_point_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_point`(`access_point_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`port_access_permit` ADD CONSTRAINT `fk_customer_port_access_permit_personnel_id` FOREIGN KEY (`personnel_id`) REFERENCES `shipping_ports_ecm`.`security`.`personnel`(`personnel_id`);

-- ========= customer --> vessel (2 constraint(s)) =========
-- Requires: customer schema, vessel schema
ALTER TABLE `shipping_ports_ecm`.`customer`.`sla_performance` ADD CONSTRAINT `fk_customer_sla_performance_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`communication_log` ADD CONSTRAINT `fk_customer_communication_log_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);

-- ========= customer --> workforce (13 constraint(s)) =========
-- Requires: customer schema, workforce schema
ALTER TABLE `shipping_ports_ecm`.`customer`.`port_community_participant` ADD CONSTRAINT `fk_customer_port_community_participant_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`participant_account` ADD CONSTRAINT `fk_customer_participant_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`accreditation` ADD CONSTRAINT `fk_customer_accreditation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`communication_log` ADD CONSTRAINT `fk_customer_communication_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`credit_assessment` ADD CONSTRAINT `fk_customer_credit_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`credit_assessment` ADD CONSTRAINT `fk_customer_credit_assessment_primary_credit_assessor_employee_id` FOREIGN KEY (`primary_credit_assessor_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`onboarding_application` ADD CONSTRAINT `fk_customer_onboarding_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`relationship_manager` ADD CONSTRAINT `fk_customer_relationship_manager_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`participant_document` ADD CONSTRAINT `fk_customer_participant_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`port_access_permit` ADD CONSTRAINT `fk_customer_port_access_permit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`location_access_authorization` ADD CONSTRAINT `fk_customer_location_access_authorization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`commodity_handling_authorization` ADD CONSTRAINT `fk_customer_commodity_handling_authorization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= finance --> asset (1 constraint(s)) =========
-- Requires: finance schema, asset schema
ALTER TABLE `shipping_ports_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_equipment_class_id` FOREIGN KEY (`equipment_class_id`) REFERENCES `shipping_ports_ecm`.`asset`.`equipment_class`(`equipment_class_id`);

-- ========= finance --> billing (4 constraint(s)) =========
-- Requires: finance schema, billing schema
ALTER TABLE `shipping_ports_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_run_id` FOREIGN KEY (`run_id`) REFERENCES `shipping_ports_ecm`.`billing`.`run`(`run_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_run_id` FOREIGN KEY (`run_id`) REFERENCES `shipping_ports_ecm`.`billing`.`run`(`run_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`receivable` ADD CONSTRAINT `fk_finance_receivable_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= finance --> compliance (2 constraint(s)) =========
-- Requires: finance schema, compliance schema
ALTER TABLE `shipping_ports_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`provision` ADD CONSTRAINT `fk_finance_provision_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`violation`(`violation_id`);

-- ========= finance --> contract (1 constraint(s)) =========
-- Requires: finance schema, contract schema
ALTER TABLE `shipping_ports_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= finance --> customer (2 constraint(s)) =========
-- Requires: finance schema, customer schema
ALTER TABLE `shipping_ports_ecm`.`finance`.`receivable` ADD CONSTRAINT `fk_finance_receivable_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);

-- ========= finance --> infrastructure (1 constraint(s)) =========
-- Requires: finance schema, infrastructure schema
ALTER TABLE `shipping_ports_ecm`.`finance`.`asset_transaction` ADD CONSTRAINT `fk_finance_asset_transaction_project_id` FOREIGN KEY (`project_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`project`(`project_id`);

-- ========= finance --> masterdata (10 constraint(s)) =========
-- Requires: finance schema, masterdata schema
ALTER TABLE `shipping_ports_ecm`.`finance`.`cost_centre` ADD CONSTRAINT `fk_finance_cost_centre_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`profit_centre` ADD CONSTRAINT `fk_finance_profit_centre_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_service_code_id` FOREIGN KEY (`service_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`service_code`(`service_code_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`receivable` ADD CONSTRAINT `fk_finance_receivable_service_code_id` FOREIGN KEY (`service_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`service_code`(`service_code_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_equipment_type_id` FOREIGN KEY (`equipment_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`equipment_type`(`equipment_type_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`asset_transaction` ADD CONSTRAINT `fk_finance_asset_transaction_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_service_code_id` FOREIGN KEY (`service_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`service_code`(`service_code_id`);

-- ========= finance --> procurement (14 constraint(s)) =========
-- Requires: finance schema, procurement schema
ALTER TABLE `shipping_ports_ecm`.`finance`.`cost_centre` ADD CONSTRAINT `fk_finance_cost_centre_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`profit_centre` ADD CONSTRAINT `fk_finance_profit_centre_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`plan`(`plan_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_material_group_id` FOREIGN KEY (`material_group_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`material_group`(`material_group_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`asset_transaction` ADD CONSTRAINT `fk_finance_asset_transaction_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`lease_liability` ADD CONSTRAINT `fk_finance_lease_liability_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= finance --> security (5 constraint(s)) =========
-- Requires: finance schema, security schema
ALTER TABLE `shipping_ports_ecm`.`finance`.`cost_centre` ADD CONSTRAINT `fk_finance_cost_centre_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_security_equipment_id` FOREIGN KEY (`security_equipment_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_equipment`(`security_equipment_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_facility_security_plan_id` FOREIGN KEY (`facility_security_plan_id`) REFERENCES `shipping_ports_ecm`.`security`.`facility_security_plan`(`facility_security_plan_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`asset_transaction` ADD CONSTRAINT `fk_finance_asset_transaction_security_equipment_id` FOREIGN KEY (`security_equipment_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_equipment`(`security_equipment_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`provision` ADD CONSTRAINT `fk_finance_provision_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);

-- ========= finance --> workforce (31 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `shipping_ports_ecm`.`finance`.`cost_centre` ADD CONSTRAINT `fk_finance_cost_centre_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`profit_centre` ADD CONSTRAINT `fk_finance_profit_centre_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_tertiary_wbs_last_modified_by_employee_id` FOREIGN KEY (`tertiary_wbs_last_modified_by_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_gang_id` FOREIGN KEY (`gang_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`gang`(`gang_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_gang_id` FOREIGN KEY (`gang_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`gang`(`gang_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_gang_id` FOREIGN KEY (`gang_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`gang`(`gang_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_gang_id` FOREIGN KEY (`gang_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`gang`(`gang_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_tertiary_budget_modified_by_employee_id` FOREIGN KEY (`tertiary_budget_modified_by_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`company_code` ADD CONSTRAINT `fk_finance_company_code_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`lease_liability` ADD CONSTRAINT `fk_finance_lease_liability_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`provision` ADD CONSTRAINT `fk_finance_provision_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`internal_order_gang_assignment` ADD CONSTRAINT `fk_finance_internal_order_gang_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`internal_order_gang_assignment` ADD CONSTRAINT `fk_finance_internal_order_gang_assignment_gang_id` FOREIGN KEY (`gang_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`gang`(`gang_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`project_gang_assignment` ADD CONSTRAINT `fk_finance_project_gang_assignment_gang_id` FOREIGN KEY (`gang_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`gang`(`gang_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`investment_program` ADD CONSTRAINT `fk_finance_investment_program_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`investment_program` ADD CONSTRAINT `fk_finance_investment_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`investment_program` ADD CONSTRAINT `fk_finance_investment_program_sponsor_employee_id` FOREIGN KEY (`sponsor_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= infrastructure --> asset (10 constraint(s)) =========
-- Requires: infrastructure schema, asset schema
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`berth` ADD CONSTRAINT `fk_infrastructure_berth_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`warehouse` ADD CONSTRAINT `fk_infrastructure_warehouse_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`navigational_aid` ADD CONSTRAINT `fk_infrastructure_navigational_aid_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`dredging_campaign` ADD CONSTRAINT `fk_infrastructure_dredging_campaign_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`port_gate` ADD CONSTRAINT `fk_infrastructure_port_gate_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`project` ADD CONSTRAINT `fk_infrastructure_project_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`structural_inspection` ADD CONSTRAINT `fk_infrastructure_structural_inspection_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`structural_inspection` ADD CONSTRAINT `fk_infrastructure_structural_inspection_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `shipping_ports_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`utility_network` ADD CONSTRAINT `fk_infrastructure_utility_network_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`closure` ADD CONSTRAINT `fk_infrastructure_closure_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `shipping_ports_ecm`.`asset`.`work_order`(`work_order_id`);

-- ========= infrastructure --> booking (5 constraint(s)) =========
-- Requires: infrastructure schema, booking schema
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`closure` ADD CONSTRAINT `fk_infrastructure_closure_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`infrastructure_berth_reservation` ADD CONSTRAINT `fk_infrastructure_infrastructure_berth_reservation_booking_berth_reservation_id` FOREIGN KEY (`booking_berth_reservation_id`) REFERENCES `shipping_ports_ecm`.`booking`.`booking_berth_reservation`(`booking_berth_reservation_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`infrastructure_berth_reservation` ADD CONSTRAINT `fk_infrastructure_infrastructure_berth_reservation_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`infrastructure_anchorage_booking` ADD CONSTRAINT `fk_infrastructure_infrastructure_anchorage_booking_booking_anchorage_booking_id` FOREIGN KEY (`booking_anchorage_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`booking_anchorage_booking`(`booking_anchorage_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`infrastructure_anchorage_booking` ADD CONSTRAINT `fk_infrastructure_infrastructure_anchorage_booking_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);

-- ========= infrastructure --> compliance (8 constraint(s)) =========
-- Requires: infrastructure schema, compliance schema
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`berth` ADD CONSTRAINT `fk_infrastructure_berth_marpol_record_id` FOREIGN KEY (`marpol_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`marpol_record`(`marpol_record_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`berth` ADD CONSTRAINT `fk_infrastructure_berth_isps_facility_record_id` FOREIGN KEY (`isps_facility_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`isps_facility_record`(`isps_facility_record_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`warehouse` ADD CONSTRAINT `fk_infrastructure_warehouse_isps_facility_record_id` FOREIGN KEY (`isps_facility_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`isps_facility_record`(`isps_facility_record_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`navigational_aid` ADD CONSTRAINT `fk_infrastructure_navigational_aid_compliance_audit_id` FOREIGN KEY (`compliance_audit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`compliance_audit`(`compliance_audit_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`dredging_campaign` ADD CONSTRAINT `fk_infrastructure_dredging_campaign_marpol_record_id` FOREIGN KEY (`marpol_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`marpol_record`(`marpol_record_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`port_gate` ADD CONSTRAINT `fk_infrastructure_port_gate_isps_facility_record_id` FOREIGN KEY (`isps_facility_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`isps_facility_record`(`isps_facility_record_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`utility_network` ADD CONSTRAINT `fk_infrastructure_utility_network_compliance_audit_id` FOREIGN KEY (`compliance_audit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`compliance_audit`(`compliance_audit_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`anchorage_area` ADD CONSTRAINT `fk_infrastructure_anchorage_area_marpol_record_id` FOREIGN KEY (`marpol_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`marpol_record`(`marpol_record_id`);

-- ========= infrastructure --> contract (5 constraint(s)) =========
-- Requires: infrastructure schema, contract schema
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`terminal_zone` ADD CONSTRAINT `fk_infrastructure_terminal_zone_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`warehouse` ADD CONSTRAINT `fk_infrastructure_warehouse_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`dredging_campaign` ADD CONSTRAINT `fk_infrastructure_dredging_campaign_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`permit` ADD CONSTRAINT `fk_infrastructure_permit_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`infrastructure_berth_allocation` ADD CONSTRAINT `fk_infrastructure_infrastructure_berth_allocation_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= infrastructure --> customer (10 constraint(s)) =========
-- Requires: infrastructure schema, customer schema
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`berth` ADD CONSTRAINT `fk_infrastructure_berth_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`terminal_zone` ADD CONSTRAINT `fk_infrastructure_terminal_zone_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`warehouse` ADD CONSTRAINT `fk_infrastructure_warehouse_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`dredging_campaign` ADD CONSTRAINT `fk_infrastructure_dredging_campaign_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`port_gate` ADD CONSTRAINT `fk_infrastructure_port_gate_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`project` ADD CONSTRAINT `fk_infrastructure_project_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`closure` ADD CONSTRAINT `fk_infrastructure_closure_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`facility` ADD CONSTRAINT `fk_infrastructure_facility_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`facility` ADD CONSTRAINT `fk_infrastructure_facility_terminal_operator_port_community_participant_id` FOREIGN KEY (`terminal_operator_port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`waste_reception_facility` ADD CONSTRAINT `fk_infrastructure_waste_reception_facility_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);

-- ========= infrastructure --> finance (13 constraint(s)) =========
-- Requires: infrastructure schema, finance schema
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`berth` ADD CONSTRAINT `fk_infrastructure_berth_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`berth` ADD CONSTRAINT `fk_infrastructure_berth_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `shipping_ports_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`quay_wall` ADD CONSTRAINT `fk_infrastructure_quay_wall_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `shipping_ports_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`terminal_zone` ADD CONSTRAINT `fk_infrastructure_terminal_zone_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`warehouse` ADD CONSTRAINT `fk_infrastructure_warehouse_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`warehouse` ADD CONSTRAINT `fk_infrastructure_warehouse_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `shipping_ports_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`navigational_aid` ADD CONSTRAINT `fk_infrastructure_navigational_aid_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `shipping_ports_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`dredging_campaign` ADD CONSTRAINT `fk_infrastructure_dredging_campaign_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`project` ADD CONSTRAINT `fk_infrastructure_project_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`project` ADD CONSTRAINT `fk_infrastructure_project_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `shipping_ports_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`structural_inspection` ADD CONSTRAINT `fk_infrastructure_structural_inspection_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`utility_network` ADD CONSTRAINT `fk_infrastructure_utility_network_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `shipping_ports_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`permit` ADD CONSTRAINT `fk_infrastructure_permit_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `shipping_ports_ecm`.`finance`.`wbs_element`(`wbs_element_id`);

-- ========= infrastructure --> masterdata (14 constraint(s)) =========
-- Requires: infrastructure schema, masterdata schema
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`berth` ADD CONSTRAINT `fk_infrastructure_berth_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`berth` ADD CONSTRAINT `fk_infrastructure_berth_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`quay_wall` ADD CONSTRAINT `fk_infrastructure_quay_wall_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`terminal_zone` ADD CONSTRAINT `fk_infrastructure_terminal_zone_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`warehouse` ADD CONSTRAINT `fk_infrastructure_warehouse_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`navigational_aid` ADD CONSTRAINT `fk_infrastructure_navigational_aid_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`channel` ADD CONSTRAINT `fk_infrastructure_channel_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`depth_survey` ADD CONSTRAINT `fk_infrastructure_depth_survey_equipment_type_id` FOREIGN KEY (`equipment_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`equipment_type`(`equipment_type_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`dredging_campaign` ADD CONSTRAINT `fk_infrastructure_dredging_campaign_equipment_type_id` FOREIGN KEY (`equipment_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`equipment_type`(`equipment_type_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`port_gate` ADD CONSTRAINT `fk_infrastructure_port_gate_equipment_type_id` FOREIGN KEY (`equipment_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`equipment_type`(`equipment_type_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`anchorage_area` ADD CONSTRAINT `fk_infrastructure_anchorage_area_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`project_service_cost` ADD CONSTRAINT `fk_infrastructure_project_service_cost_service_code_id` FOREIGN KEY (`service_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`service_code`(`service_code_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`warehouse_commodity_approval` ADD CONSTRAINT `fk_infrastructure_warehouse_commodity_approval_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`warehouse_imdg_approval` ADD CONSTRAINT `fk_infrastructure_warehouse_imdg_approval_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);

-- ========= infrastructure --> procurement (13 constraint(s)) =========
-- Requires: infrastructure schema, procurement schema
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`berth` ADD CONSTRAINT `fk_infrastructure_berth_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`quay_wall` ADD CONSTRAINT `fk_infrastructure_quay_wall_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`warehouse` ADD CONSTRAINT `fk_infrastructure_warehouse_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`navigational_aid` ADD CONSTRAINT `fk_infrastructure_navigational_aid_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`dredging_campaign` ADD CONSTRAINT `fk_infrastructure_dredging_campaign_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`project` ADD CONSTRAINT `fk_infrastructure_project_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`project` ADD CONSTRAINT `fk_infrastructure_project_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`project` ADD CONSTRAINT `fk_infrastructure_project_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`structural_inspection` ADD CONSTRAINT `fk_infrastructure_structural_inspection_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`utility_network` ADD CONSTRAINT `fk_infrastructure_utility_network_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`closure` ADD CONSTRAINT `fk_infrastructure_closure_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`permit` ADD CONSTRAINT `fk_infrastructure_permit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`berth_service_contract` ADD CONSTRAINT `fk_infrastructure_berth_service_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= infrastructure --> safety (1 constraint(s)) =========
-- Requires: infrastructure schema, safety schema
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`closure` ADD CONSTRAINT `fk_infrastructure_closure_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `shipping_ports_ecm`.`safety`.`emergency_response_plan`(`emergency_response_plan_id`);

-- ========= infrastructure --> security (13 constraint(s)) =========
-- Requires: infrastructure schema, security schema
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`berth` ADD CONSTRAINT `fk_infrastructure_berth_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`terminal_zone` ADD CONSTRAINT `fk_infrastructure_terminal_zone_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`warehouse` ADD CONSTRAINT `fk_infrastructure_warehouse_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`navigational_aid` ADD CONSTRAINT `fk_infrastructure_navigational_aid_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`channel` ADD CONSTRAINT `fk_infrastructure_channel_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`depth_survey` ADD CONSTRAINT `fk_infrastructure_depth_survey_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`dredging_campaign` ADD CONSTRAINT `fk_infrastructure_dredging_campaign_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`port_gate` ADD CONSTRAINT `fk_infrastructure_port_gate_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`project` ADD CONSTRAINT `fk_infrastructure_project_facility_security_plan_id` FOREIGN KEY (`facility_security_plan_id`) REFERENCES `shipping_ports_ecm`.`security`.`facility_security_plan`(`facility_security_plan_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`project` ADD CONSTRAINT `fk_infrastructure_project_threat_assessment_id` FOREIGN KEY (`threat_assessment_id`) REFERENCES `shipping_ports_ecm`.`security`.`threat_assessment`(`threat_assessment_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`structural_inspection` ADD CONSTRAINT `fk_infrastructure_structural_inspection_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`anchorage_area` ADD CONSTRAINT `fk_infrastructure_anchorage_area_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`permit` ADD CONSTRAINT `fk_infrastructure_permit_facility_security_plan_id` FOREIGN KEY (`facility_security_plan_id`) REFERENCES `shipping_ports_ecm`.`security`.`facility_security_plan`(`facility_security_plan_id`);

-- ========= infrastructure --> tariff (1 constraint(s)) =========
-- Requires: infrastructure schema, tariff schema
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`closure` ADD CONSTRAINT `fk_infrastructure_closure_exception_id` FOREIGN KEY (`exception_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`exception`(`exception_id`);

-- ========= infrastructure --> terminal (1 constraint(s)) =========
-- Requires: infrastructure schema, terminal schema
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`infrastructure_berth_allocation` ADD CONSTRAINT `fk_infrastructure_infrastructure_berth_allocation_terminal_berth_allocation_id` FOREIGN KEY (`terminal_berth_allocation_id`) REFERENCES `shipping_ports_ecm`.`terminal`.`terminal_berth_allocation`(`terminal_berth_allocation_id`);

-- ========= infrastructure --> workforce (16 constraint(s)) =========
-- Requires: infrastructure schema, workforce schema
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`berth` ADD CONSTRAINT `fk_infrastructure_berth_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`quay_wall` ADD CONSTRAINT `fk_infrastructure_quay_wall_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`terminal_zone` ADD CONSTRAINT `fk_infrastructure_terminal_zone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`warehouse` ADD CONSTRAINT `fk_infrastructure_warehouse_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`navigational_aid` ADD CONSTRAINT `fk_infrastructure_navigational_aid_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`channel` ADD CONSTRAINT `fk_infrastructure_channel_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`depth_survey` ADD CONSTRAINT `fk_infrastructure_depth_survey_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`dredging_campaign` ADD CONSTRAINT `fk_infrastructure_dredging_campaign_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`port_gate` ADD CONSTRAINT `fk_infrastructure_port_gate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`project` ADD CONSTRAINT `fk_infrastructure_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`structural_inspection` ADD CONSTRAINT `fk_infrastructure_structural_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`utility_network` ADD CONSTRAINT `fk_infrastructure_utility_network_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`closure` ADD CONSTRAINT `fk_infrastructure_closure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`permit` ADD CONSTRAINT `fk_infrastructure_permit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`infrastructure_anchorage_booking` ADD CONSTRAINT `fk_infrastructure_infrastructure_anchorage_booking_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`project_service_cost` ADD CONSTRAINT `fk_infrastructure_project_service_cost_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= intermodal --> asset (6 constraint(s)) =========
-- Requires: intermodal schema, asset schema
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_visit` ADD CONSTRAINT `fk_intermodal_rail_visit_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_wagon` ADD CONSTRAINT `fk_intermodal_rail_wagon_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_visit` ADD CONSTRAINT `fk_intermodal_truck_visit_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);

-- ========= intermodal --> booking (6 constraint(s)) =========
-- Requires: intermodal schema, booking schema
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`slot_booking` ADD CONSTRAINT `fk_intermodal_slot_booking_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);

-- ========= intermodal --> cargo (9 constraint(s)) =========
-- Requires: intermodal schema, cargo schema
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_visit` ADD CONSTRAINT `fk_intermodal_rail_visit_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`manifest`(`manifest_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_container_id` FOREIGN KEY (`container_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`container`(`container_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_container_id` FOREIGN KEY (`container_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`container`(`container_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`intermodal_rail_wagon_load` ADD CONSTRAINT `fk_intermodal_intermodal_rail_wagon_load_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`intermodal_rail_wagon_load` ADD CONSTRAINT `fk_intermodal_intermodal_rail_wagon_load_container_id` FOREIGN KEY (`container_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`container`(`container_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`edi_message` ADD CONSTRAINT `fk_intermodal_edi_message_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`last_mile_event` ADD CONSTRAINT `fk_intermodal_last_mile_event_container_id` FOREIGN KEY (`container_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`container`(`container_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`last_mile_event` ADD CONSTRAINT `fk_intermodal_last_mile_event_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`shipment`(`shipment_id`);

-- ========= intermodal --> compliance (18 constraint(s)) =========
-- Requires: intermodal schema, compliance schema
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_visit` ADD CONSTRAINT `fk_intermodal_rail_visit_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_visit` ADD CONSTRAINT `fk_intermodal_truck_visit_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_visit` ADD CONSTRAINT `fk_intermodal_truck_visit_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_trade_document_id` FOREIGN KEY (`trade_document_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`trade_document`(`trade_document_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`icd_facility` ADD CONSTRAINT `fk_intermodal_icd_facility_customs_broker_id` FOREIGN KEY (`customs_broker_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_broker`(`customs_broker_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_import_export_permit_id` FOREIGN KEY (`import_export_permit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`import_export_permit`(`import_export_permit_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_trade_document_id` FOREIGN KEY (`trade_document_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`trade_document`(`trade_document_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_trade_restriction_id` FOREIGN KEY (`trade_restriction_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`trade_restriction`(`trade_restriction_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`haulier` ADD CONSTRAINT `fk_intermodal_haulier_customs_broker_id` FOREIGN KEY (`customs_broker_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_broker`(`customs_broker_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_operator` ADD CONSTRAINT `fk_intermodal_rail_operator_customs_broker_id` FOREIGN KEY (`customs_broker_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_broker`(`customs_broker_id`);

-- ========= intermodal --> contract (9 constraint(s)) =========
-- Requires: intermodal schema, contract schema
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_visit` ADD CONSTRAINT `fk_intermodal_rail_visit_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`icd_facility` ADD CONSTRAINT `fk_intermodal_icd_facility_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`haulier` ADD CONSTRAINT `fk_intermodal_haulier_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_operator` ADD CONSTRAINT `fk_intermodal_rail_operator_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`service` ADD CONSTRAINT `fk_intermodal_service_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`slot_booking` ADD CONSTRAINT `fk_intermodal_slot_booking_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= intermodal --> customer (12 constraint(s)) =========
-- Requires: intermodal schema, customer schema
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_port_access_permit_id` FOREIGN KEY (`port_access_permit_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_access_permit`(`port_access_permit_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_tertiary_transport_carrier_participant_account_id` FOREIGN KEY (`tertiary_transport_carrier_participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`edi_message` ADD CONSTRAINT `fk_intermodal_edi_message_edi_subscription_id` FOREIGN KEY (`edi_subscription_id`) REFERENCES `shipping_ports_ecm`.`customer`.`edi_subscription`(`edi_subscription_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`haulier` ADD CONSTRAINT `fk_intermodal_haulier_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_operator` ADD CONSTRAINT `fk_intermodal_rail_operator_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`service` ADD CONSTRAINT `fk_intermodal_service_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`slot_booking` ADD CONSTRAINT `fk_intermodal_slot_booking_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`facility_access_agreement` ADD CONSTRAINT `fk_intermodal_facility_access_agreement_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`service_subscription` ADD CONSTRAINT `fk_intermodal_service_subscription_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);

-- ========= intermodal --> finance (11 constraint(s)) =========
-- Requires: intermodal schema, finance schema
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_visit` ADD CONSTRAINT `fk_intermodal_rail_visit_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_visit` ADD CONSTRAINT `fk_intermodal_rail_visit_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `shipping_ports_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`icd_facility` ADD CONSTRAINT `fk_intermodal_icd_facility_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`icd_facility` ADD CONSTRAINT `fk_intermodal_icd_facility_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`icd_facility` ADD CONSTRAINT `fk_intermodal_icd_facility_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `shipping_ports_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`service` ADD CONSTRAINT `fk_intermodal_service_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`service` ADD CONSTRAINT `fk_intermodal_service_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);

-- ========= intermodal --> infrastructure (15 constraint(s)) =========
-- Requires: intermodal schema, infrastructure schema
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_visit` ADD CONSTRAINT `fk_intermodal_rail_visit_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_port_gate_id` FOREIGN KEY (`port_gate_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port_gate`(`port_gate_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`slot_booking` ADD CONSTRAINT `fk_intermodal_slot_booking_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`last_mile_event` ADD CONSTRAINT `fk_intermodal_last_mile_event_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`last_mile_event` ADD CONSTRAINT `fk_intermodal_last_mile_event_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`last_mile_event` ADD CONSTRAINT `fk_intermodal_last_mile_event_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);

-- ========= intermodal --> masterdata (20 constraint(s)) =========
-- Requires: intermodal schema, masterdata schema
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_visit` ADD CONSTRAINT `fk_intermodal_rail_visit_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_wagon` ADD CONSTRAINT `fk_intermodal_rail_wagon_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`container_type`(`container_type_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_visit` ADD CONSTRAINT `fk_intermodal_truck_visit_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`container_type`(`container_type_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`icd_facility` ADD CONSTRAINT `fk_intermodal_icd_facility_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`container_type`(`container_type_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_destination_node_port_location_id` FOREIGN KEY (`destination_node_port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`intermodal_rail_wagon_load` ADD CONSTRAINT `fk_intermodal_intermodal_rail_wagon_load_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`edi_message` ADD CONSTRAINT `fk_intermodal_edi_message_edi_partner_id` FOREIGN KEY (`edi_partner_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`edi_partner`(`edi_partner_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`haulier` ADD CONSTRAINT `fk_intermodal_haulier_edi_partner_id` FOREIGN KEY (`edi_partner_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`edi_partner`(`edi_partner_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_operator` ADD CONSTRAINT `fk_intermodal_rail_operator_edi_partner_id` FOREIGN KEY (`edi_partner_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`edi_partner`(`edi_partner_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`service` ADD CONSTRAINT `fk_intermodal_service_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`last_mile_event` ADD CONSTRAINT `fk_intermodal_last_mile_event_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`last_mile_event` ADD CONSTRAINT `fk_intermodal_last_mile_event_primary_last_port_location_id` FOREIGN KEY (`primary_last_port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);

-- ========= intermodal --> procurement (2 constraint(s)) =========
-- Requires: intermodal schema, procurement schema
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`haulier` ADD CONSTRAINT `fk_intermodal_haulier_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_operator` ADD CONSTRAINT `fk_intermodal_rail_operator_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= intermodal --> safety (12 constraint(s)) =========
-- Requires: intermodal schema, safety schema
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_visit` ADD CONSTRAINT `fk_intermodal_rail_visit_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `shipping_ports_ecm`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_wagon` ADD CONSTRAINT `fk_intermodal_rail_wagon_ghg_emission_record_id` FOREIGN KEY (`ghg_emission_record_id`) REFERENCES `shipping_ports_ecm`.`safety`.`ghg_emission_record`(`ghg_emission_record_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_wagon` ADD CONSTRAINT `fk_intermodal_rail_wagon_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `shipping_ports_ecm`.`safety`.`inspection`(`inspection_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `shipping_ports_ecm`.`safety`.`inspection`(`inspection_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `shipping_ports_ecm`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_visit` ADD CONSTRAINT `fk_intermodal_truck_visit_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `shipping_ports_ecm`.`safety`.`inspection`(`inspection_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_ohs_incident_id` FOREIGN KEY (`ohs_incident_id`) REFERENCES `shipping_ports_ecm`.`safety`.`ohs_incident`(`ohs_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`icd_facility` ADD CONSTRAINT `fk_intermodal_icd_facility_env_monitoring_station_id` FOREIGN KEY (`env_monitoring_station_id`) REFERENCES `shipping_ports_ecm`.`safety`.`env_monitoring_station`(`env_monitoring_station_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_ohs_incident_id` FOREIGN KEY (`ohs_incident_id`) REFERENCES `shipping_ports_ecm`.`safety`.`ohs_incident`(`ohs_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`haulier` ADD CONSTRAINT `fk_intermodal_haulier_contractor_safety_id` FOREIGN KEY (`contractor_safety_id`) REFERENCES `shipping_ports_ecm`.`safety`.`contractor_safety`(`contractor_safety_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_operator` ADD CONSTRAINT `fk_intermodal_rail_operator_contractor_safety_id` FOREIGN KEY (`contractor_safety_id`) REFERENCES `shipping_ports_ecm`.`safety`.`contractor_safety`(`contractor_safety_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`service` ADD CONSTRAINT `fk_intermodal_service_sustainability_initiative_id` FOREIGN KEY (`sustainability_initiative_id`) REFERENCES `shipping_ports_ecm`.`safety`.`sustainability_initiative`(`sustainability_initiative_id`);

-- ========= intermodal --> security (13 constraint(s)) =========
-- Requires: intermodal schema, security schema
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_visit` ADD CONSTRAINT `fk_intermodal_rail_visit_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_access_credential_id` FOREIGN KEY (`access_credential_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_credential`(`access_credential_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_visit` ADD CONSTRAINT `fk_intermodal_truck_visit_access_event_id` FOREIGN KEY (`access_event_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_event`(`access_event_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_visit` ADD CONSTRAINT `fk_intermodal_truck_visit_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_access_credential_id` FOREIGN KEY (`access_credential_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_credential`(`access_credential_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`icd_facility` ADD CONSTRAINT `fk_intermodal_icd_facility_facility_security_plan_id` FOREIGN KEY (`facility_security_plan_id`) REFERENCES `shipping_ports_ecm`.`security`.`facility_security_plan`(`facility_security_plan_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`edi_message` ADD CONSTRAINT `fk_intermodal_edi_message_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`haulier` ADD CONSTRAINT `fk_intermodal_haulier_access_credential_id` FOREIGN KEY (`access_credential_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_credential`(`access_credential_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_operator` ADD CONSTRAINT `fk_intermodal_rail_operator_facility_security_plan_id` FOREIGN KEY (`facility_security_plan_id`) REFERENCES `shipping_ports_ecm`.`security`.`facility_security_plan`(`facility_security_plan_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`service` ADD CONSTRAINT `fk_intermodal_service_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);

-- ========= intermodal --> tariff (6 constraint(s)) =========
-- Requires: intermodal schema, tariff schema
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_visit` ADD CONSTRAINT `fk_intermodal_rail_visit_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_thc_schedule_id` FOREIGN KEY (`thc_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`thc_schedule`(`thc_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`service` ADD CONSTRAINT `fk_intermodal_service_port_tariff_id` FOREIGN KEY (`port_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_tariff`(`port_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`slot_booking` ADD CONSTRAINT `fk_intermodal_slot_booking_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);

-- ========= intermodal --> terminal (2 constraint(s)) =========
-- Requires: intermodal schema, terminal schema
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_visit` ADD CONSTRAINT `fk_intermodal_truck_visit_gate_transaction_id` FOREIGN KEY (`gate_transaction_id`) REFERENCES `shipping_ports_ecm`.`terminal`.`gate_transaction`(`gate_transaction_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_equipment_dispatch_id` FOREIGN KEY (`equipment_dispatch_id`) REFERENCES `shipping_ports_ecm`.`terminal`.`equipment_dispatch`(`equipment_dispatch_id`);

-- ========= intermodal --> vessel (5 constraint(s)) =========
-- Requires: intermodal schema, vessel schema
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_voyage_id` FOREIGN KEY (`voyage_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`voyage`(`voyage_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`intermodal_rail_wagon_load` ADD CONSTRAINT `fk_intermodal_intermodal_rail_wagon_load_voyage_id` FOREIGN KEY (`voyage_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`voyage`(`voyage_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`slot_booking` ADD CONSTRAINT `fk_intermodal_slot_booking_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);

-- ========= intermodal --> workforce (12 constraint(s)) =========
-- Requires: intermodal schema, workforce schema
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_visit` ADD CONSTRAINT `fk_intermodal_rail_visit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_visit` ADD CONSTRAINT `fk_intermodal_truck_visit_driver_employee_id` FOREIGN KEY (`driver_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_visit` ADD CONSTRAINT `fk_intermodal_truck_visit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`icd_facility` ADD CONSTRAINT `fk_intermodal_icd_facility_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`intermodal_rail_wagon_load` ADD CONSTRAINT `fk_intermodal_intermodal_rail_wagon_load_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`service` ADD CONSTRAINT `fk_intermodal_service_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`last_mile_event` ADD CONSTRAINT `fk_intermodal_last_mile_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`haulier_icd_service_agreement` ADD CONSTRAINT `fk_intermodal_haulier_icd_service_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`driver_authorization` ADD CONSTRAINT `fk_intermodal_driver_authorization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= marine --> asset (6 constraint(s)) =========
-- Requires: marine schema, asset schema
ALTER TABLE `shipping_ports_ecm`.`marine`.`towage_order` ADD CONSTRAINT `fk_marine_towage_order_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`tug` ADD CONSTRAINT `fk_marine_tug_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`mooring_operation` ADD CONSTRAINT `fk_marine_mooring_operation_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`launch_dispatch` ADD CONSTRAINT `fk_marine_launch_dispatch_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_incident` ADD CONSTRAINT `fk_marine_marine_incident_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marpol_operation` ADD CONSTRAINT `fk_marine_marpol_operation_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);

-- ========= marine --> billing (10 constraint(s)) =========
-- Requires: marine schema, billing schema
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_assignment` ADD CONSTRAINT `fk_marine_pilotage_assignment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`towage_order` ADD CONSTRAINT `fk_marine_towage_order_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`mooring_operation` ADD CONSTRAINT `fk_marine_mooring_operation_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`launch_dispatch` ADD CONSTRAINT `fk_marine_launch_dispatch_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`survey_appointment` ADD CONSTRAINT `fk_marine_survey_appointment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pni_club_notification` ADD CONSTRAINT `fk_marine_pni_club_notification_adjustment_id` FOREIGN KEY (`adjustment_id`) REFERENCES `shipping_ports_ecm`.`billing`.`adjustment`(`adjustment_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marpol_operation` ADD CONSTRAINT `fk_marine_marpol_operation_charge_event_id` FOREIGN KEY (`charge_event_id`) REFERENCES `shipping_ports_ecm`.`billing`.`charge_event`(`charge_event_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_proforma_invoice_id` FOREIGN KEY (`proforma_invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`proforma_invoice`(`proforma_invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`tug_assignment` ADD CONSTRAINT `fk_marine_tug_assignment_charge_event_id` FOREIGN KEY (`charge_event_id`) REFERENCES `shipping_ports_ecm`.`billing`.`charge_event`(`charge_event_id`);

-- ========= marine --> booking (8 constraint(s)) =========
-- Requires: marine schema, booking schema
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_assignment` ADD CONSTRAINT `fk_marine_pilotage_assignment_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`towage_order` ADD CONSTRAINT `fk_marine_towage_order_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`mooring_operation` ADD CONSTRAINT `fk_marine_mooring_operation_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`launch_dispatch` ADD CONSTRAINT `fk_marine_launch_dispatch_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`survey_appointment` ADD CONSTRAINT `fk_marine_survey_appointment_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_incident` ADD CONSTRAINT `fk_marine_marine_incident_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pni_club_notification` ADD CONSTRAINT `fk_marine_pni_club_notification_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marpol_operation` ADD CONSTRAINT `fk_marine_marpol_operation_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);

-- ========= marine --> compliance (6 constraint(s)) =========
-- Requires: marine schema, compliance schema
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_assignment` ADD CONSTRAINT `fk_marine_pilotage_assignment_isps_facility_record_id` FOREIGN KEY (`isps_facility_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`isps_facility_record`(`isps_facility_record_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_incident` ADD CONSTRAINT `fk_marine_marine_incident_marpol_record_id` FOREIGN KEY (`marpol_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`marpol_record`(`marpol_record_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_incident` ADD CONSTRAINT `fk_marine_marine_incident_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pni_club_notification` ADD CONSTRAINT `fk_marine_pni_club_notification_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marpol_operation` ADD CONSTRAINT `fk_marine_marpol_operation_marpol_record_id` FOREIGN KEY (`marpol_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`marpol_record`(`marpol_record_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);

-- ========= marine --> contract (7 constraint(s)) =========
-- Requires: marine schema, contract schema
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_assignment` ADD CONSTRAINT `fk_marine_pilotage_assignment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`towage_order` ADD CONSTRAINT `fk_marine_towage_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`tug` ADD CONSTRAINT `fk_marine_tug_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`mooring_operation` ADD CONSTRAINT `fk_marine_mooring_operation_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`survey_appointment` ADD CONSTRAINT `fk_marine_survey_appointment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`surveyor_authorization` ADD CONSTRAINT `fk_marine_surveyor_authorization_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= marine --> customer (6 constraint(s)) =========
-- Requires: marine schema, customer schema
ALTER TABLE `shipping_ports_ecm`.`marine`.`towage_order` ADD CONSTRAINT `fk_marine_towage_order_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`survey_appointment` ADD CONSTRAINT `fk_marine_survey_appointment_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pni_club_notification` ADD CONSTRAINT `fk_marine_pni_club_notification_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marpol_operation` ADD CONSTRAINT `fk_marine_marpol_operation_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_tertiary_marine_approved_mooring_provider_port_community_participant_id` FOREIGN KEY (`tertiary_marine_approved_mooring_provider_port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);

-- ========= marine --> finance (12 constraint(s)) =========
-- Requires: marine schema, finance schema
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_assignment` ADD CONSTRAINT `fk_marine_pilotage_assignment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`towage_order` ADD CONSTRAINT `fk_marine_towage_order_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`tug` ADD CONSTRAINT `fk_marine_tug_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `shipping_ports_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`mooring_operation` ADD CONSTRAINT `fk_marine_mooring_operation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`launch_dispatch` ADD CONSTRAINT `fk_marine_launch_dispatch_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`survey_appointment` ADD CONSTRAINT `fk_marine_survey_appointment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_incident` ADD CONSTRAINT `fk_marine_marine_incident_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_incident` ADD CONSTRAINT `fk_marine_marine_incident_provision_id` FOREIGN KEY (`provision_id`) REFERENCES `shipping_ports_ecm`.`finance`.`provision`(`provision_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pni_club_notification` ADD CONSTRAINT `fk_marine_pni_club_notification_provision_id` FOREIGN KEY (`provision_id`) REFERENCES `shipping_ports_ecm`.`finance`.`provision`(`provision_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marpol_operation` ADD CONSTRAINT `fk_marine_marpol_operation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`tug_assignment` ADD CONSTRAINT `fk_marine_tug_assignment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);

-- ========= marine --> infrastructure (22 constraint(s)) =========
-- Requires: marine schema, infrastructure schema
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_assignment` ADD CONSTRAINT `fk_marine_pilotage_assignment_anchorage_area_id` FOREIGN KEY (`anchorage_area_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`anchorage_area`(`anchorage_area_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_assignment` ADD CONSTRAINT `fk_marine_pilotage_assignment_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`channel`(`channel_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`towage_order` ADD CONSTRAINT `fk_marine_towage_order_anchorage_area_id` FOREIGN KEY (`anchorage_area_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`anchorage_area`(`anchorage_area_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`towage_order` ADD CONSTRAINT `fk_marine_towage_order_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`towage_order` ADD CONSTRAINT `fk_marine_towage_order_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`channel`(`channel_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`mooring_operation` ADD CONSTRAINT `fk_marine_mooring_operation_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`mooring_operation` ADD CONSTRAINT `fk_marine_mooring_operation_quay_wall_id` FOREIGN KEY (`quay_wall_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`quay_wall`(`quay_wall_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`launch_dispatch` ADD CONSTRAINT `fk_marine_launch_dispatch_anchorage_area_id` FOREIGN KEY (`anchorage_area_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`anchorage_area`(`anchorage_area_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`survey_appointment` ADD CONSTRAINT `fk_marine_survey_appointment_anchorage_area_id` FOREIGN KEY (`anchorage_area_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`anchorage_area`(`anchorage_area_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`survey_appointment` ADD CONSTRAINT `fk_marine_survey_appointment_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`survey_appointment` ADD CONSTRAINT `fk_marine_survey_appointment_quay_wall_id` FOREIGN KEY (`quay_wall_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`quay_wall`(`quay_wall_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_incident` ADD CONSTRAINT `fk_marine_marine_incident_anchorage_area_id` FOREIGN KEY (`anchorage_area_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`anchorage_area`(`anchorage_area_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_incident` ADD CONSTRAINT `fk_marine_marine_incident_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_incident` ADD CONSTRAINT `fk_marine_marine_incident_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`channel`(`channel_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_incident` ADD CONSTRAINT `fk_marine_marine_incident_quay_wall_id` FOREIGN KEY (`quay_wall_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`quay_wall`(`quay_wall_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pni_club_notification` ADD CONSTRAINT `fk_marine_pni_club_notification_anchorage_area_id` FOREIGN KEY (`anchorage_area_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`anchorage_area`(`anchorage_area_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pni_club_notification` ADD CONSTRAINT `fk_marine_pni_club_notification_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pni_club_notification` ADD CONSTRAINT `fk_marine_pni_club_notification_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`channel`(`channel_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pni_club_notification` ADD CONSTRAINT `fk_marine_pni_club_notification_quay_wall_id` FOREIGN KEY (`quay_wall_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`quay_wall`(`quay_wall_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`weather_tide_window` ADD CONSTRAINT `fk_marine_weather_tide_window_anchorage_area_id` FOREIGN KEY (`anchorage_area_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`anchorage_area`(`anchorage_area_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`weather_tide_window` ADD CONSTRAINT `fk_marine_weather_tide_window_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`channel`(`channel_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilot_channel_authorisation` ADD CONSTRAINT `fk_marine_pilot_channel_authorisation_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`channel`(`channel_id`);

-- ========= marine --> intermodal (11 constraint(s)) =========
-- Requires: marine schema, intermodal schema
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_assignment` ADD CONSTRAINT `fk_marine_pilotage_assignment_rail_visit_id` FOREIGN KEY (`rail_visit_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`rail_visit`(`rail_visit_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`towage_order` ADD CONSTRAINT `fk_marine_towage_order_rail_visit_id` FOREIGN KEY (`rail_visit_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`rail_visit`(`rail_visit_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`mooring_operation` ADD CONSTRAINT `fk_marine_mooring_operation_rail_visit_id` FOREIGN KEY (`rail_visit_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`rail_visit`(`rail_visit_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`survey_appointment` ADD CONSTRAINT `fk_marine_survey_appointment_truck_appointment_id` FOREIGN KEY (`truck_appointment_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`truck_appointment`(`truck_appointment_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_incident` ADD CONSTRAINT `fk_marine_marine_incident_rail_visit_id` FOREIGN KEY (`rail_visit_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`rail_visit`(`rail_visit_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_incident` ADD CONSTRAINT `fk_marine_marine_incident_truck_visit_id` FOREIGN KEY (`truck_visit_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`truck_visit`(`truck_visit_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pni_club_notification` ADD CONSTRAINT `fk_marine_pni_club_notification_drayage_order_id` FOREIGN KEY (`drayage_order_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`drayage_order`(`drayage_order_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pni_club_notification` ADD CONSTRAINT `fk_marine_pni_club_notification_truck_visit_id` FOREIGN KEY (`truck_visit_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`truck_visit`(`truck_visit_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marpol_operation` ADD CONSTRAINT `fk_marine_marpol_operation_truck_visit_id` FOREIGN KEY (`truck_visit_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`truck_visit`(`truck_visit_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_rail_visit_id` FOREIGN KEY (`rail_visit_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`rail_visit`(`rail_visit_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_truck_appointment_id` FOREIGN KEY (`truck_appointment_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`truck_appointment`(`truck_appointment_id`);

-- ========= marine --> masterdata (21 constraint(s)) =========
-- Requires: marine schema, masterdata schema
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_assignment` ADD CONSTRAINT `fk_marine_pilotage_assignment_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_assignment` ADD CONSTRAINT `fk_marine_pilotage_assignment_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilot` ADD CONSTRAINT `fk_marine_pilot_country_id` FOREIGN KEY (`country_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`towage_order` ADD CONSTRAINT `fk_marine_towage_order_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`towage_order` ADD CONSTRAINT `fk_marine_towage_order_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`tug` ADD CONSTRAINT `fk_marine_tug_flag_state_id` FOREIGN KEY (`flag_state_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`flag_state`(`flag_state_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`tug` ADD CONSTRAINT `fk_marine_tug_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`tug` ADD CONSTRAINT `fk_marine_tug_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`mooring_operation` ADD CONSTRAINT `fk_marine_mooring_operation_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`launch_dispatch` ADD CONSTRAINT `fk_marine_launch_dispatch_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`surveyor` ADD CONSTRAINT `fk_marine_surveyor_country_id` FOREIGN KEY (`country_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`survey_appointment` ADD CONSTRAINT `fk_marine_survey_appointment_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`survey_appointment` ADD CONSTRAINT `fk_marine_survey_appointment_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_incident` ADD CONSTRAINT `fk_marine_marine_incident_flag_state_id` FOREIGN KEY (`flag_state_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`flag_state`(`flag_state_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_incident` ADD CONSTRAINT `fk_marine_marine_incident_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pni_club_notification` ADD CONSTRAINT `fk_marine_pni_club_notification_flag_state_id` FOREIGN KEY (`flag_state_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`flag_state`(`flag_state_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pni_club_notification` ADD CONSTRAINT `fk_marine_pni_club_notification_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marpol_operation` ADD CONSTRAINT `fk_marine_marpol_operation_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marpol_operation` ADD CONSTRAINT `fk_marine_marpol_operation_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_service_code_id` FOREIGN KEY (`service_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`service_code`(`service_code_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilot_vessel_type_endorsement` ADD CONSTRAINT `fk_marine_pilot_vessel_type_endorsement_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);

-- ========= marine --> procurement (1 constraint(s)) =========
-- Requires: marine schema, procurement schema
ALTER TABLE `shipping_ports_ecm`.`marine`.`tug` ADD CONSTRAINT `fk_marine_tug_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= marine --> safety (5 constraint(s)) =========
-- Requires: marine schema, safety schema
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_assignment` ADD CONSTRAINT `fk_marine_pilotage_assignment_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `shipping_ports_ecm`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`towage_order` ADD CONSTRAINT `fk_marine_towage_order_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `shipping_ports_ecm`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`mooring_operation` ADD CONSTRAINT `fk_marine_mooring_operation_ohs_incident_id` FOREIGN KEY (`ohs_incident_id`) REFERENCES `shipping_ports_ecm`.`safety`.`ohs_incident`(`ohs_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`mooring_operation` ADD CONSTRAINT `fk_marine_mooring_operation_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `shipping_ports_ecm`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`launch_dispatch` ADD CONSTRAINT `fk_marine_launch_dispatch_ohs_incident_id` FOREIGN KEY (`ohs_incident_id`) REFERENCES `shipping_ports_ecm`.`safety`.`ohs_incident`(`ohs_incident_id`);

-- ========= marine --> security (11 constraint(s)) =========
-- Requires: marine schema, security schema
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_assignment` ADD CONSTRAINT `fk_marine_pilotage_assignment_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`mooring_operation` ADD CONSTRAINT `fk_marine_mooring_operation_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`launch_dispatch` ADD CONSTRAINT `fk_marine_launch_dispatch_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`survey_appointment` ADD CONSTRAINT `fk_marine_survey_appointment_personnel_id` FOREIGN KEY (`personnel_id`) REFERENCES `shipping_ports_ecm`.`security`.`personnel`(`personnel_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_incident` ADD CONSTRAINT `fk_marine_marine_incident_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pni_club_notification` ADD CONSTRAINT `fk_marine_pni_club_notification_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marpol_operation` ADD CONSTRAINT `fk_marine_marpol_operation_personnel_id` FOREIGN KEY (`personnel_id`) REFERENCES `shipping_ports_ecm`.`security`.`personnel`(`personnel_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilot_duty_roster` ADD CONSTRAINT `fk_marine_pilot_duty_roster_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`tug_assignment` ADD CONSTRAINT `fk_marine_tug_assignment_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`weather_tide_window` ADD CONSTRAINT `fk_marine_weather_tide_window_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);

-- ========= marine --> tariff (4 constraint(s)) =========
-- Requires: marine schema, tariff schema
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_assignment` ADD CONSTRAINT `fk_marine_pilotage_assignment_pilotage_tariff_id` FOREIGN KEY (`pilotage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`pilotage_tariff`(`pilotage_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_mooring_tariff_id` FOREIGN KEY (`mooring_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`mooring_tariff`(`mooring_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_pilotage_tariff_id` FOREIGN KEY (`pilotage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`pilotage_tariff`(`pilotage_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_towage_tariff_id` FOREIGN KEY (`towage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`towage_tariff`(`towage_tariff_id`);

-- ========= marine --> vessel (19 constraint(s)) =========
-- Requires: marine schema, vessel schema
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_assignment` ADD CONSTRAINT `fk_marine_pilotage_assignment_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_assignment` ADD CONSTRAINT `fk_marine_pilotage_assignment_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_assignment` ADD CONSTRAINT `fk_marine_pilotage_assignment_voyage_id` FOREIGN KEY (`voyage_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`voyage`(`voyage_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`towage_order` ADD CONSTRAINT `fk_marine_towage_order_agent_appointment_id` FOREIGN KEY (`agent_appointment_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`agent_appointment`(`agent_appointment_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`towage_order` ADD CONSTRAINT `fk_marine_towage_order_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`towage_order` ADD CONSTRAINT `fk_marine_towage_order_towage_port_call_id` FOREIGN KEY (`towage_port_call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`towage_order` ADD CONSTRAINT `fk_marine_towage_order_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`mooring_operation` ADD CONSTRAINT `fk_marine_mooring_operation_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`mooring_operation` ADD CONSTRAINT `fk_marine_mooring_operation_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`launch_dispatch` ADD CONSTRAINT `fk_marine_launch_dispatch_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`survey_appointment` ADD CONSTRAINT `fk_marine_survey_appointment_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`survey_appointment` ADD CONSTRAINT `fk_marine_survey_appointment_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_incident` ADD CONSTRAINT `fk_marine_marine_incident_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pni_club_notification` ADD CONSTRAINT `fk_marine_pni_club_notification_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pni_club_notification` ADD CONSTRAINT `fk_marine_pni_club_notification_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marpol_operation` ADD CONSTRAINT `fk_marine_marpol_operation_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marpol_operation` ADD CONSTRAINT `fk_marine_marpol_operation_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_agent_appointment_id` FOREIGN KEY (`agent_appointment_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`agent_appointment`(`agent_appointment_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);

-- ========= marine --> workforce (17 constraint(s)) =========
-- Requires: marine schema, workforce schema
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_assignment` ADD CONSTRAINT `fk_marine_pilotage_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilot` ADD CONSTRAINT `fk_marine_pilot_labour_agreement_id` FOREIGN KEY (`labour_agreement_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`labour_agreement`(`labour_agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilot` ADD CONSTRAINT `fk_marine_pilot_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilot` ADD CONSTRAINT `fk_marine_pilot_position_id` FOREIGN KEY (`position_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`towage_order` ADD CONSTRAINT `fk_marine_towage_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`mooring_operation` ADD CONSTRAINT `fk_marine_mooring_operation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`mooring_operation` ADD CONSTRAINT `fk_marine_mooring_operation_gang_id` FOREIGN KEY (`gang_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`gang`(`gang_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`launch_dispatch` ADD CONSTRAINT `fk_marine_launch_dispatch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`survey_appointment` ADD CONSTRAINT `fk_marine_survey_appointment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_incident` ADD CONSTRAINT `fk_marine_marine_incident_gang_id` FOREIGN KEY (`gang_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`gang`(`gang_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_incident` ADD CONSTRAINT `fk_marine_marine_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pni_club_notification` ADD CONSTRAINT `fk_marine_pni_club_notification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marpol_operation` ADD CONSTRAINT `fk_marine_marpol_operation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilot_duty_roster` ADD CONSTRAINT `fk_marine_pilot_duty_roster_shift_pattern_id` FOREIGN KEY (`shift_pattern_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`shift_pattern`(`shift_pattern_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`tug_assignment` ADD CONSTRAINT `fk_marine_tug_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`weather_tide_window` ADD CONSTRAINT `fk_marine_weather_tide_window_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= masterdata --> customer (1 constraint(s)) =========
-- Requires: masterdata schema, customer schema
ALTER TABLE `shipping_ports_ecm`.`masterdata`.`edi_partner` ADD CONSTRAINT `fk_masterdata_edi_partner_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);

-- ========= procurement --> asset (2 constraint(s)) =========
-- Requires: procurement schema, asset schema
ALTER TABLE `shipping_ports_ecm`.`procurement`.`purchase_order_item` ADD CONSTRAINT `fk_procurement_purchase_order_item_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `shipping_ports_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `shipping_ports_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_location_id` FOREIGN KEY (`location_id`) REFERENCES `shipping_ports_ecm`.`asset`.`location`(`location_id`);

-- ========= procurement --> booking (1 constraint(s)) =========
-- Requires: procurement schema, booking schema
ALTER TABLE `shipping_ports_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_booking_service_order_id` FOREIGN KEY (`booking_service_order_id`) REFERENCES `shipping_ports_ecm`.`booking`.`booking_service_order`(`booking_service_order_id`);

-- ========= procurement --> compliance (1 constraint(s)) =========
-- Requires: procurement schema, compliance schema
ALTER TABLE `shipping_ports_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);

-- ========= procurement --> contract (1 constraint(s)) =========
-- Requires: procurement schema, contract schema
ALTER TABLE `shipping_ports_ecm`.`procurement`.`tender` ADD CONSTRAINT `fk_procurement_tender_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= procurement --> customer (1 constraint(s)) =========
-- Requires: procurement schema, customer schema
ALTER TABLE `shipping_ports_ecm`.`procurement`.`vendor` ADD CONSTRAINT `fk_procurement_vendor_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);

-- ========= procurement --> masterdata (11 constraint(s)) =========
-- Requires: procurement schema, masterdata schema
ALTER TABLE `shipping_ports_ecm`.`procurement`.`vendor` ADD CONSTRAINT `fk_procurement_vendor_country_id` FOREIGN KEY (`country_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `shipping_ports_ecm`.`procurement`.`vendor` ADD CONSTRAINT `fk_procurement_vendor_un_locode_id` FOREIGN KEY (`un_locode_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`un_locode`(`un_locode_id`);
ALTER TABLE `shipping_ports_ecm`.`procurement`.`material_master` ADD CONSTRAINT `fk_procurement_material_master_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`procurement`.`material_master` ADD CONSTRAINT `fk_procurement_material_master_packaging_type_id` FOREIGN KEY (`packaging_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`packaging_type`(`packaging_type_id`);
ALTER TABLE `shipping_ports_ecm`.`procurement`.`material_group` ADD CONSTRAINT `fk_procurement_material_group_cargo_category_id` FOREIGN KEY (`cargo_category_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`cargo_category`(`cargo_category_id`);
ALTER TABLE `shipping_ports_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`procurement`.`purchase_order_item` ADD CONSTRAINT `fk_procurement_purchase_order_item_equipment_type_id` FOREIGN KEY (`equipment_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`equipment_type`(`equipment_type_id`);
ALTER TABLE `shipping_ports_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`procurement`.`vendor_service_rate_card` ADD CONSTRAINT `fk_procurement_vendor_service_rate_card_service_code_id` FOREIGN KEY (`service_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`service_code`(`service_code_id`);
ALTER TABLE `shipping_ports_ecm`.`procurement`.`vendor_commodity_approval` ADD CONSTRAINT `fk_procurement_vendor_commodity_approval_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);

-- ========= procurement --> safety (1 constraint(s)) =========
-- Requires: procurement schema, safety schema
ALTER TABLE `shipping_ports_ecm`.`procurement`.`vendor_evaluation` ADD CONSTRAINT `fk_procurement_vendor_evaluation_kpi_id` FOREIGN KEY (`kpi_id`) REFERENCES `shipping_ports_ecm`.`safety`.`kpi`(`kpi_id`);

-- ========= procurement --> security (3 constraint(s)) =========
-- Requires: procurement schema, security schema
ALTER TABLE `shipping_ports_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`procurement`.`purchase_order_item` ADD CONSTRAINT `fk_procurement_purchase_order_item_security_equipment_id` FOREIGN KEY (`security_equipment_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_equipment`(`security_equipment_id`);
ALTER TABLE `shipping_ports_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_access_point_id` FOREIGN KEY (`access_point_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_point`(`access_point_id`);

-- ========= procurement --> workforce (14 constraint(s)) =========
-- Requires: procurement schema, workforce schema
ALTER TABLE `shipping_ports_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `shipping_ports_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`procurement`.`vendor_quotation` ADD CONSTRAINT `fk_procurement_vendor_quotation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_primary_service_employee_id` FOREIGN KEY (`primary_service_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_tertiary_service_created_by_user_employee_id` FOREIGN KEY (`tertiary_service_created_by_user_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`procurement`.`vendor_evaluation` ADD CONSTRAINT `fk_procurement_vendor_evaluation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`procurement`.`tender` ADD CONSTRAINT `fk_procurement_tender_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`procurement`.`tender` ADD CONSTRAINT `fk_procurement_tender_tender_employee_id` FOREIGN KEY (`tender_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`procurement`.`tender` ADD CONSTRAINT `fk_procurement_tender_tender_manager_user_employee_id` FOREIGN KEY (`tender_manager_user_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`procurement`.`tender` ADD CONSTRAINT `fk_procurement_tender_tender_modified_by_user_employee_id` FOREIGN KEY (`tender_modified_by_user_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`procurement`.`vendor_commodity_approval` ADD CONSTRAINT `fk_procurement_vendor_commodity_approval_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= safety --> asset (3 constraint(s)) =========
-- Requires: safety schema, asset schema
ALTER TABLE `shipping_ports_ecm`.`safety`.`inspection` ADD CONSTRAINT `fk_safety_inspection_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`env_monitoring_station` ADD CONSTRAINT `fk_safety_env_monitoring_station_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`ghg_emission_record` ADD CONSTRAINT `fk_safety_ghg_emission_record_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);

-- ========= safety --> booking (9 constraint(s)) =========
-- Requires: safety schema, booking schema
ALTER TABLE `shipping_ports_ecm`.`safety`.`ohs_incident` ADD CONSTRAINT `fk_safety_ohs_incident_booking_berth_reservation_id` FOREIGN KEY (`booking_berth_reservation_id`) REFERENCES `shipping_ports_ecm`.`booking`.`booking_berth_reservation`(`booking_berth_reservation_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`ohs_incident` ADD CONSTRAINT `fk_safety_ohs_incident_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`inspection` ADD CONSTRAINT `fk_safety_inspection_booking_berth_reservation_id` FOREIGN KEY (`booking_berth_reservation_id`) REFERENCES `shipping_ports_ecm`.`booking`.`booking_berth_reservation`(`booking_berth_reservation_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`inspection` ADD CONSTRAINT `fk_safety_inspection_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`safety_corrective_action` ADD CONSTRAINT `fk_safety_safety_corrective_action_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`env_monitoring_reading` ADD CONSTRAINT `fk_safety_env_monitoring_reading_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`ghg_emission_record` ADD CONSTRAINT `fk_safety_ghg_emission_record_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`marpol_waste_record` ADD CONSTRAINT `fk_safety_marpol_waste_record_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`contractor_safety` ADD CONSTRAINT `fk_safety_contractor_safety_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);

-- ========= safety --> compliance (9 constraint(s)) =========
-- Requires: safety schema, compliance schema
ALTER TABLE `shipping_ports_ecm`.`safety`.`ohs_incident` ADD CONSTRAINT `fk_safety_ohs_incident_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`ohs_incident` ADD CONSTRAINT `fk_safety_ohs_incident_isps_facility_record_id` FOREIGN KEY (`isps_facility_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`isps_facility_record`(`isps_facility_record_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`inspection` ADD CONSTRAINT `fk_safety_inspection_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`inspection` ADD CONSTRAINT `fk_safety_inspection_isps_facility_record_id` FOREIGN KEY (`isps_facility_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`isps_facility_record`(`isps_facility_record_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`safety_corrective_action` ADD CONSTRAINT `fk_safety_safety_corrective_action_compliance_audit_id` FOREIGN KEY (`compliance_audit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`compliance_audit`(`compliance_audit_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`safety_corrective_action` ADD CONSTRAINT `fk_safety_safety_corrective_action_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`env_monitoring_reading` ADD CONSTRAINT `fk_safety_env_monitoring_reading_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`marpol_waste_record` ADD CONSTRAINT `fk_safety_marpol_waste_record_marpol_record_id` FOREIGN KEY (`marpol_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`marpol_record`(`marpol_record_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`iso_compliance_register` ADD CONSTRAINT `fk_safety_iso_compliance_register_compliance_audit_id` FOREIGN KEY (`compliance_audit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`compliance_audit`(`compliance_audit_id`);

-- ========= safety --> contract (8 constraint(s)) =========
-- Requires: safety schema, contract schema
ALTER TABLE `shipping_ports_ecm`.`safety`.`ohs_incident` ADD CONSTRAINT `fk_safety_ohs_incident_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`inspection` ADD CONSTRAINT `fk_safety_inspection_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`safety_corrective_action` ADD CONSTRAINT `fk_safety_safety_corrective_action_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`env_monitoring_reading` ADD CONSTRAINT `fk_safety_env_monitoring_reading_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`ghg_emission_record` ADD CONSTRAINT `fk_safety_ghg_emission_record_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`marpol_waste_record` ADD CONSTRAINT `fk_safety_marpol_waste_record_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`contractor_safety` ADD CONSTRAINT `fk_safety_contractor_safety_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= safety --> customer (7 constraint(s)) =========
-- Requires: safety schema, customer schema
ALTER TABLE `shipping_ports_ecm`.`safety`.`ohs_incident` ADD CONSTRAINT `fk_safety_ohs_incident_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`inspection` ADD CONSTRAINT `fk_safety_inspection_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`marpol_waste_record` ADD CONSTRAINT `fk_safety_marpol_waste_record_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`contractor_safety` ADD CONSTRAINT `fk_safety_contractor_safety_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`emergency_response_participant` ADD CONSTRAINT `fk_safety_emergency_response_participant_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`risk_assessment_participant` ADD CONSTRAINT `fk_safety_risk_assessment_participant_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);

-- ========= safety --> finance (11 constraint(s)) =========
-- Requires: safety schema, finance schema
ALTER TABLE `shipping_ports_ecm`.`safety`.`ohs_incident` ADD CONSTRAINT `fk_safety_ohs_incident_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`ohs_incident` ADD CONSTRAINT `fk_safety_ohs_incident_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `shipping_ports_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`inspection` ADD CONSTRAINT `fk_safety_inspection_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`safety_corrective_action` ADD CONSTRAINT `fk_safety_safety_corrective_action_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`safety_corrective_action` ADD CONSTRAINT `fk_safety_safety_corrective_action_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `shipping_ports_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`env_monitoring_station` ADD CONSTRAINT `fk_safety_env_monitoring_station_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `shipping_ports_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`ghg_emission_record` ADD CONSTRAINT `fk_safety_ghg_emission_record_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `shipping_ports_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`marpol_waste_record` ADD CONSTRAINT `fk_safety_marpol_waste_record_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`sustainability_initiative` ADD CONSTRAINT `fk_safety_sustainability_initiative_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`sustainability_initiative` ADD CONSTRAINT `fk_safety_sustainability_initiative_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `shipping_ports_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);

-- ========= safety --> infrastructure (54 constraint(s)) =========
-- Requires: safety schema, infrastructure schema
ALTER TABLE `shipping_ports_ecm`.`safety`.`ohs_incident` ADD CONSTRAINT `fk_safety_ohs_incident_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`ohs_incident` ADD CONSTRAINT `fk_safety_ohs_incident_port_gate_id` FOREIGN KEY (`port_gate_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port_gate`(`port_gate_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`ohs_incident` ADD CONSTRAINT `fk_safety_ohs_incident_project_id` FOREIGN KEY (`project_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`project`(`project_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`ohs_incident` ADD CONSTRAINT `fk_safety_ohs_incident_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`ohs_incident` ADD CONSTRAINT `fk_safety_ohs_incident_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`inspection` ADD CONSTRAINT `fk_safety_inspection_anchorage_area_id` FOREIGN KEY (`anchorage_area_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`anchorage_area`(`anchorage_area_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`inspection` ADD CONSTRAINT `fk_safety_inspection_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`inspection` ADD CONSTRAINT `fk_safety_inspection_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`channel`(`channel_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`inspection` ADD CONSTRAINT `fk_safety_inspection_navigational_aid_id` FOREIGN KEY (`navigational_aid_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`navigational_aid`(`navigational_aid_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`inspection` ADD CONSTRAINT `fk_safety_inspection_port_gate_id` FOREIGN KEY (`port_gate_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port_gate`(`port_gate_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`inspection` ADD CONSTRAINT `fk_safety_inspection_project_id` FOREIGN KEY (`project_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`project`(`project_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`inspection` ADD CONSTRAINT `fk_safety_inspection_quay_wall_id` FOREIGN KEY (`quay_wall_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`quay_wall`(`quay_wall_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`inspection` ADD CONSTRAINT `fk_safety_inspection_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`inspection` ADD CONSTRAINT `fk_safety_inspection_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`channel`(`channel_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_project_id` FOREIGN KEY (`project_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`project`(`project_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_project_id` FOREIGN KEY (`project_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`project`(`project_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`env_monitoring_station` ADD CONSTRAINT `fk_safety_env_monitoring_station_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`env_monitoring_station` ADD CONSTRAINT `fk_safety_env_monitoring_station_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`channel`(`channel_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`env_monitoring_station` ADD CONSTRAINT `fk_safety_env_monitoring_station_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`env_monitoring_station` ADD CONSTRAINT `fk_safety_env_monitoring_station_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`ghg_emission_record` ADD CONSTRAINT `fk_safety_ghg_emission_record_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`ghg_emission_record` ADD CONSTRAINT `fk_safety_ghg_emission_record_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`channel`(`channel_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`ghg_emission_record` ADD CONSTRAINT `fk_safety_ghg_emission_record_port_gate_id` FOREIGN KEY (`port_gate_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port_gate`(`port_gate_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`ghg_emission_record` ADD CONSTRAINT `fk_safety_ghg_emission_record_project_id` FOREIGN KEY (`project_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`project`(`project_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`ghg_emission_record` ADD CONSTRAINT `fk_safety_ghg_emission_record_quay_wall_id` FOREIGN KEY (`quay_wall_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`quay_wall`(`quay_wall_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`ghg_emission_record` ADD CONSTRAINT `fk_safety_ghg_emission_record_terminal_terminal_zone_id` FOREIGN KEY (`terminal_terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`ghg_emission_record` ADD CONSTRAINT `fk_safety_ghg_emission_record_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`ghg_emission_record` ADD CONSTRAINT `fk_safety_ghg_emission_record_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`marpol_waste_record` ADD CONSTRAINT `fk_safety_marpol_waste_record_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`marpol_waste_record` ADD CONSTRAINT `fk_safety_marpol_waste_record_waste_reception_facility_id` FOREIGN KEY (`waste_reception_facility_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`waste_reception_facility`(`waste_reception_facility_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`marpol_waste_record` ADD CONSTRAINT `fk_safety_marpol_waste_record_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`sustainability_initiative` ADD CONSTRAINT `fk_safety_sustainability_initiative_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`sustainability_initiative` ADD CONSTRAINT `fk_safety_sustainability_initiative_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`channel`(`channel_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`sustainability_initiative` ADD CONSTRAINT `fk_safety_sustainability_initiative_project_id` FOREIGN KEY (`project_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`project`(`project_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`sustainability_initiative` ADD CONSTRAINT `fk_safety_sustainability_initiative_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`sustainability_initiative` ADD CONSTRAINT `fk_safety_sustainability_initiative_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`channel`(`channel_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_navigational_aid_id` FOREIGN KEY (`navigational_aid_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`navigational_aid`(`navigational_aid_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_project_id` FOREIGN KEY (`project_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`project`(`project_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_quay_wall_id` FOREIGN KEY (`quay_wall_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`quay_wall`(`quay_wall_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`kpi` ADD CONSTRAINT `fk_safety_kpi_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`kpi` ADD CONSTRAINT `fk_safety_kpi_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal`(`terminal_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`kpi` ADD CONSTRAINT `fk_safety_kpi_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`kpi` ADD CONSTRAINT `fk_safety_kpi_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);

-- ========= safety --> marine (8 constraint(s)) =========
-- Requires: safety schema, marine schema
ALTER TABLE `shipping_ports_ecm`.`safety`.`inspection` ADD CONSTRAINT `fk_safety_inspection_tug_id` FOREIGN KEY (`tug_id`) REFERENCES `shipping_ports_ecm`.`marine`.`tug`(`tug_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`env_monitoring_reading` ADD CONSTRAINT `fk_safety_env_monitoring_reading_marine_incident_id` FOREIGN KEY (`marine_incident_id`) REFERENCES `shipping_ports_ecm`.`marine`.`marine_incident`(`marine_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`env_monitoring_reading` ADD CONSTRAINT `fk_safety_env_monitoring_reading_marpol_operation_id` FOREIGN KEY (`marpol_operation_id`) REFERENCES `shipping_ports_ecm`.`marine`.`marpol_operation`(`marpol_operation_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`ghg_emission_record` ADD CONSTRAINT `fk_safety_ghg_emission_record_marine_incident_id` FOREIGN KEY (`marine_incident_id`) REFERENCES `shipping_ports_ecm`.`marine`.`marine_incident`(`marine_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`ghg_emission_record` ADD CONSTRAINT `fk_safety_ghg_emission_record_tug_id` FOREIGN KEY (`tug_id`) REFERENCES `shipping_ports_ecm`.`marine`.`tug`(`tug_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`marpol_waste_record` ADD CONSTRAINT `fk_safety_marpol_waste_record_marpol_operation_id` FOREIGN KEY (`marpol_operation_id`) REFERENCES `shipping_ports_ecm`.`marine`.`marpol_operation`(`marpol_operation_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`contractor_safety` ADD CONSTRAINT `fk_safety_contractor_safety_pilot_id` FOREIGN KEY (`pilot_id`) REFERENCES `shipping_ports_ecm`.`marine`.`pilot`(`pilot_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`contractor_safety` ADD CONSTRAINT `fk_safety_contractor_safety_surveyor_id` FOREIGN KEY (`surveyor_id`) REFERENCES `shipping_ports_ecm`.`marine`.`surveyor`(`surveyor_id`);

-- ========= safety --> masterdata (12 constraint(s)) =========
-- Requires: safety schema, masterdata schema
ALTER TABLE `shipping_ports_ecm`.`safety`.`ohs_incident` ADD CONSTRAINT `fk_safety_ohs_incident_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`inspection` ADD CONSTRAINT `fk_safety_inspection_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`inspection` ADD CONSTRAINT `fk_safety_inspection_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`env_monitoring_reading` ADD CONSTRAINT `fk_safety_env_monitoring_reading_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`ghg_emission_record` ADD CONSTRAINT `fk_safety_ghg_emission_record_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`marpol_waste_record` ADD CONSTRAINT `fk_safety_marpol_waste_record_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`marpol_waste_record` ADD CONSTRAINT `fk_safety_marpol_waste_record_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`sustainability_initiative` ADD CONSTRAINT `fk_safety_sustainability_initiative_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`contractor_safety` ADD CONSTRAINT `fk_safety_contractor_safety_service_code_id` FOREIGN KEY (`service_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`service_code`(`service_code_id`);

-- ========= safety --> procurement (16 constraint(s)) =========
-- Requires: safety schema, procurement schema
ALTER TABLE `shipping_ports_ecm`.`safety`.`ohs_incident` ADD CONSTRAINT `fk_safety_ohs_incident_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`inspection` ADD CONSTRAINT `fk_safety_inspection_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`inspection` ADD CONSTRAINT `fk_safety_inspection_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_material_group_id` FOREIGN KEY (`material_group_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`material_group`(`material_group_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_material_group_id` FOREIGN KEY (`material_group_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`material_group`(`material_group_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`safety_corrective_action` ADD CONSTRAINT `fk_safety_safety_corrective_action_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`env_monitoring_station` ADD CONSTRAINT `fk_safety_env_monitoring_station_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`ghg_emission_record` ADD CONSTRAINT `fk_safety_ghg_emission_record_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`marpol_waste_record` ADD CONSTRAINT `fk_safety_marpol_waste_record_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`marpol_waste_record` ADD CONSTRAINT `fk_safety_marpol_waste_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`iso_compliance_register` ADD CONSTRAINT `fk_safety_iso_compliance_register_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`contractor_safety` ADD CONSTRAINT `fk_safety_contractor_safety_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`contractor_safety` ADD CONSTRAINT `fk_safety_contractor_safety_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`material_hazard_control` ADD CONSTRAINT `fk_safety_material_hazard_control_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`permit_vendor_authorization` ADD CONSTRAINT `fk_safety_permit_vendor_authorization_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= safety --> security (8 constraint(s)) =========
-- Requires: safety schema, security schema
ALTER TABLE `shipping_ports_ecm`.`safety`.`ohs_incident` ADD CONSTRAINT `fk_safety_ohs_incident_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`inspection` ADD CONSTRAINT `fk_safety_inspection_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`inspection` ADD CONSTRAINT `fk_safety_inspection_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`safety_corrective_action` ADD CONSTRAINT `fk_safety_safety_corrective_action_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`emergency_response_plan` ADD CONSTRAINT `fk_safety_emergency_response_plan_facility_security_plan_id` FOREIGN KEY (`facility_security_plan_id`) REFERENCES `shipping_ports_ecm`.`security`.`facility_security_plan`(`facility_security_plan_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`env_monitoring_station` ADD CONSTRAINT `fk_safety_env_monitoring_station_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`contractor_safety` ADD CONSTRAINT `fk_safety_contractor_safety_access_credential_id` FOREIGN KEY (`access_credential_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_credential`(`access_credential_id`);

-- ========= safety --> tariff (3 constraint(s)) =========
-- Requires: safety schema, tariff schema
ALTER TABLE `shipping_ports_ecm`.`safety`.`ghg_emission_record` ADD CONSTRAINT `fk_safety_ghg_emission_record_surcharge_rule_id` FOREIGN KEY (`surcharge_rule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`surcharge_rule`(`surcharge_rule_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`marpol_waste_record` ADD CONSTRAINT `fk_safety_marpol_waste_record_item_id` FOREIGN KEY (`item_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`item`(`item_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`sustainability_initiative` ADD CONSTRAINT `fk_safety_sustainability_initiative_discount_scheme_id` FOREIGN KEY (`discount_scheme_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`discount_scheme`(`discount_scheme_id`);

-- ========= safety --> terminal (1 constraint(s)) =========
-- Requires: safety schema, terminal schema
ALTER TABLE `shipping_ports_ecm`.`safety`.`env_monitoring_reading` ADD CONSTRAINT `fk_safety_env_monitoring_reading_terminal_equipment_id` FOREIGN KEY (`terminal_equipment_id`) REFERENCES `shipping_ports_ecm`.`terminal`.`terminal_equipment`(`terminal_equipment_id`);

-- ========= safety --> vessel (4 constraint(s)) =========
-- Requires: safety schema, vessel schema
ALTER TABLE `shipping_ports_ecm`.`safety`.`env_monitoring_reading` ADD CONSTRAINT `fk_safety_env_monitoring_reading_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`ghg_emission_record` ADD CONSTRAINT `fk_safety_ghg_emission_record_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`marpol_waste_record` ADD CONSTRAINT `fk_safety_marpol_waste_record_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`marpol_waste_record` ADD CONSTRAINT `fk_safety_marpol_waste_record_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);

-- ========= safety --> workforce (24 constraint(s)) =========
-- Requires: safety schema, workforce schema
ALTER TABLE `shipping_ports_ecm`.`safety`.`ohs_incident` ADD CONSTRAINT `fk_safety_ohs_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`ohs_investigation` ADD CONSTRAINT `fk_safety_ohs_investigation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`inspection` ADD CONSTRAINT `fk_safety_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`inspection` ADD CONSTRAINT `fk_safety_inspection_inspection_created_by_employee_id` FOREIGN KEY (`inspection_created_by_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`inspection` ADD CONSTRAINT `fk_safety_inspection_inspection_employee_id` FOREIGN KEY (`inspection_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`inspection` ADD CONSTRAINT `fk_safety_inspection_inspection_last_modified_by_employee_id` FOREIGN KEY (`inspection_last_modified_by_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`inspection` ADD CONSTRAINT `fk_safety_inspection_inspection_responsible_manager_employee_id` FOREIGN KEY (`inspection_responsible_manager_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`safety_corrective_action` ADD CONSTRAINT `fk_safety_safety_corrective_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`safety_corrective_action` ADD CONSTRAINT `fk_safety_safety_corrective_action_quaternary_safety_created_by_employee_id` FOREIGN KEY (`quaternary_safety_created_by_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`safety_corrective_action` ADD CONSTRAINT `fk_safety_safety_corrective_action_quinary_safety_last_modified_by_employee_id` FOREIGN KEY (`quinary_safety_last_modified_by_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`safety_corrective_action` ADD CONSTRAINT `fk_safety_safety_corrective_action_tertiary_safety_closed_by_employee_id` FOREIGN KEY (`tertiary_safety_closed_by_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`env_monitoring_station` ADD CONSTRAINT `fk_safety_env_monitoring_station_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`marpol_waste_record` ADD CONSTRAINT `fk_safety_marpol_waste_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`sustainability_initiative` ADD CONSTRAINT `fk_safety_sustainability_initiative_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`iso_compliance_register` ADD CONSTRAINT `fk_safety_iso_compliance_register_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_tertiary_permit_closure_verified_by_employee_id` FOREIGN KEY (`tertiary_permit_closure_verified_by_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`kpi` ADD CONSTRAINT `fk_safety_kpi_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`kpi` ADD CONSTRAINT `fk_safety_kpi_kpi_responsible_manager_employee_id` FOREIGN KEY (`kpi_responsible_manager_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`kpi` ADD CONSTRAINT `fk_safety_kpi_kpi_verified_by_employee_id` FOREIGN KEY (`kpi_verified_by_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`contractor_safety` ADD CONSTRAINT `fk_safety_contractor_safety_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`material_hazard_control` ADD CONSTRAINT `fk_safety_material_hazard_control_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`safety`.`material_hazard_control` ADD CONSTRAINT `fk_safety_material_hazard_control_last_modified_by_employee_id` FOREIGN KEY (`last_modified_by_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= security --> compliance (3 constraint(s)) =========
-- Requires: security schema, compliance schema
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ADD CONSTRAINT `fk_security_facility_security_plan_isps_facility_record_id` FOREIGN KEY (`isps_facility_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`isps_facility_record`(`isps_facility_record_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ADD CONSTRAINT `fk_security_access_credential_customs_broker_id` FOREIGN KEY (`customs_broker_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_broker`(`customs_broker_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`threat_assessment` ADD CONSTRAINT `fk_security_threat_assessment_isps_facility_record_id` FOREIGN KEY (`isps_facility_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`isps_facility_record`(`isps_facility_record_id`);

-- ========= security --> customer (1 constraint(s)) =========
-- Requires: security schema, customer schema
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ADD CONSTRAINT `fk_security_access_credential_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);

-- ========= security --> infrastructure (8 constraint(s)) =========
-- Requires: security schema, infrastructure schema
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ADD CONSTRAINT `fk_security_access_point_facility_building_id` FOREIGN KEY (`facility_building_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`facility_building`(`facility_building_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`cctv_camera` ADD CONSTRAINT `fk_security_cctv_camera_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`channel`(`channel_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`dos_record` ADD CONSTRAINT `fk_security_dos_record_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`post` ADD CONSTRAINT `fk_security_post_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`post` ADD CONSTRAINT `fk_security_post_facility_building_id` FOREIGN KEY (`facility_building_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`facility_building`(`facility_building_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`post` ADD CONSTRAINT `fk_security_post_port_gate_id` FOREIGN KEY (`port_gate_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port_gate`(`port_gate_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`patrol_route` ADD CONSTRAINT `fk_security_patrol_route_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`facility`(`facility_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`patrol_route` ADD CONSTRAINT `fk_security_patrol_route_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal`(`terminal_id`);

-- ========= security --> marine (1 constraint(s)) =========
-- Requires: security schema, marine schema
ALTER TABLE `shipping_ports_ecm`.`security`.`patrol` ADD CONSTRAINT `fk_security_patrol_marine_incident_id` FOREIGN KEY (`marine_incident_id`) REFERENCES `shipping_ports_ecm`.`marine`.`marine_incident`(`marine_incident_id`);

-- ========= security --> masterdata (10 constraint(s)) =========
-- Requires: security schema, masterdata schema
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ADD CONSTRAINT `fk_security_facility_security_plan_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ADD CONSTRAINT `fk_security_facility_security_plan_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ADD CONSTRAINT `fk_security_facility_security_plan_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ADD CONSTRAINT `fk_security_zone_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ADD CONSTRAINT `fk_security_access_point_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`threat_assessment` ADD CONSTRAINT `fk_security_threat_assessment_flag_state_id` FOREIGN KEY (`flag_state_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`flag_state`(`flag_state_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`dos_record` ADD CONSTRAINT `fk_security_dos_record_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`stowaway_case` ADD CONSTRAINT `fk_security_stowaway_case_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`watchlist_entry` ADD CONSTRAINT `fk_security_watchlist_entry_country_id` FOREIGN KEY (`country_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`security_equipment` ADD CONSTRAINT `fk_security_security_equipment_equipment_type_id` FOREIGN KEY (`equipment_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`equipment_type`(`equipment_type_id`);

-- ========= security --> procurement (1 constraint(s)) =========
-- Requires: security schema, procurement schema
ALTER TABLE `shipping_ports_ecm`.`security`.`personnel` ADD CONSTRAINT `fk_security_personnel_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= security --> safety (1 constraint(s)) =========
-- Requires: security schema, safety schema
ALTER TABLE `shipping_ports_ecm`.`security`.`patrol_route` ADD CONSTRAINT `fk_security_patrol_route_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `shipping_ports_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);

-- ========= security --> vessel (4 constraint(s)) =========
-- Requires: security schema, vessel schema
ALTER TABLE `shipping_ports_ecm`.`security`.`threat_assessment` ADD CONSTRAINT `fk_security_threat_assessment_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`dos_record` ADD CONSTRAINT `fk_security_dos_record_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`stowaway_case` ADD CONSTRAINT `fk_security_stowaway_case_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`mda_observation` ADD CONSTRAINT `fk_security_mda_observation_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);

-- ========= security --> workforce (20 constraint(s)) =========
-- Requires: security schema, workforce schema
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ADD CONSTRAINT `fk_security_facility_security_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ADD CONSTRAINT `fk_security_zone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ADD CONSTRAINT `fk_security_zone_zone_employee_id` FOREIGN KEY (`zone_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ADD CONSTRAINT `fk_security_zone_zone_manager_employee_id` FOREIGN KEY (`zone_manager_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ADD CONSTRAINT `fk_security_access_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`cctv_incident_clip` ADD CONSTRAINT `fk_security_cctv_incident_clip_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`patrol` ADD CONSTRAINT `fk_security_patrol_shift_pattern_id` FOREIGN KEY (`shift_pattern_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`shift_pattern`(`shift_pattern_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ADD CONSTRAINT `fk_security_security_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`investigation` ADD CONSTRAINT `fk_security_investigation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`drill` ADD CONSTRAINT `fk_security_drill_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`drill` ADD CONSTRAINT `fk_security_drill_drill_employee_id` FOREIGN KEY (`drill_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`stowaway_case` ADD CONSTRAINT `fk_security_stowaway_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`cyber_incident` ADD CONSTRAINT `fk_security_cyber_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`cyber_risk_register` ADD CONSTRAINT `fk_security_cyber_risk_register_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`cyber_risk_register` ADD CONSTRAINT `fk_security_cyber_risk_register_primary_cyber_employee_id` FOREIGN KEY (`primary_cyber_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`personnel` ADD CONSTRAINT `fk_security_personnel_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`post` ADD CONSTRAINT `fk_security_post_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`post` ADD CONSTRAINT `fk_security_post_supervisor_employee_id` FOREIGN KEY (`supervisor_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`visitor_log` ADD CONSTRAINT `fk_security_visitor_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`security_corrective_action` ADD CONSTRAINT `fk_security_security_corrective_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= tariff --> billing (1 constraint(s)) =========
-- Requires: tariff schema, billing schema
ALTER TABLE `shipping_ports_ecm`.`tariff`.`item` ADD CONSTRAINT `fk_tariff_item_charge_event_id` FOREIGN KEY (`charge_event_id`) REFERENCES `shipping_ports_ecm`.`billing`.`charge_event`(`charge_event_id`);

-- ========= tariff --> cargo (1 constraint(s)) =========
-- Requires: tariff schema, cargo schema
ALTER TABLE `shipping_ports_ecm`.`tariff`.`exception` ADD CONSTRAINT `fk_tariff_exception_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`shipment`(`shipment_id`);

-- ========= tariff --> compliance (11 constraint(s)) =========
-- Requires: tariff schema, compliance schema
ALTER TABLE `shipping_ports_ecm`.`tariff`.`port_tariff` ADD CONSTRAINT `fk_tariff_port_tariff_trade_restriction_id` FOREIGN KEY (`trade_restriction_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`trade_restriction`(`trade_restriction_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`item` ADD CONSTRAINT `fk_tariff_item_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`hs_code`(`hs_code_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`item` ADD CONSTRAINT `fk_tariff_item_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`rate_card` ADD CONSTRAINT `fk_tariff_rate_card_customs_broker_id` FOREIGN KEY (`customs_broker_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_broker`(`customs_broker_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`wharfage_schedule` ADD CONSTRAINT `fk_tariff_wharfage_schedule_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`hs_code`(`hs_code_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`storage_tariff` ADD CONSTRAINT `fk_tariff_storage_tariff_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`hs_code`(`hs_code_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`surcharge_rule` ADD CONSTRAINT `fk_tariff_surcharge_rule_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`exception` ADD CONSTRAINT `fk_tariff_exception_import_export_permit_id` FOREIGN KEY (`import_export_permit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`import_export_permit`(`import_export_permit_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`pricing_rule` ADD CONSTRAINT `fk_tariff_pricing_rule_trade_restriction_id` FOREIGN KEY (`trade_restriction_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`trade_restriction`(`trade_restriction_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`port_dues_schedule` ADD CONSTRAINT `fk_tariff_port_dues_schedule_isps_facility_record_id` FOREIGN KEY (`isps_facility_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`isps_facility_record`(`isps_facility_record_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`filing` ADD CONSTRAINT `fk_tariff_filing_compliance_audit_id` FOREIGN KEY (`compliance_audit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`compliance_audit`(`compliance_audit_id`);

-- ========= tariff --> contract (6 constraint(s)) =========
-- Requires: tariff schema, contract schema
ALTER TABLE `shipping_ports_ecm`.`tariff`.`rate_card` ADD CONSTRAINT `fk_tariff_rate_card_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`exception` ADD CONSTRAINT `fk_tariff_exception_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`pricing_rule` ADD CONSTRAINT `fk_tariff_pricing_rule_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`free_time_allowance` ADD CONSTRAINT `fk_tariff_free_time_allowance_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`applicability` ADD CONSTRAINT `fk_tariff_applicability_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`negotiation` ADD CONSTRAINT `fk_tariff_negotiation_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= tariff --> customer (5 constraint(s)) =========
-- Requires: tariff schema, customer schema
ALTER TABLE `shipping_ports_ecm`.`tariff`.`rate_card` ADD CONSTRAINT `fk_tariff_rate_card_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`exception` ADD CONSTRAINT `fk_tariff_exception_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`pricing_rule` ADD CONSTRAINT `fk_tariff_pricing_rule_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`applicability` ADD CONSTRAINT `fk_tariff_applicability_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`negotiation` ADD CONSTRAINT `fk_tariff_negotiation_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);

-- ========= tariff --> finance (7 constraint(s)) =========
-- Requires: tariff schema, finance schema
ALTER TABLE `shipping_ports_ecm`.`tariff`.`item` ADD CONSTRAINT `fk_tariff_item_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`rate_card` ADD CONSTRAINT `fk_tariff_rate_card_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`rate_card` ADD CONSTRAINT `fk_tariff_rate_card_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`exception` ADD CONSTRAINT `fk_tariff_exception_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`exception` ADD CONSTRAINT `fk_tariff_exception_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`pricing_rule` ADD CONSTRAINT `fk_tariff_pricing_rule_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`pricing_rule` ADD CONSTRAINT `fk_tariff_pricing_rule_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);

-- ========= tariff --> infrastructure (17 constraint(s)) =========
-- Requires: tariff schema, infrastructure schema
ALTER TABLE `shipping_ports_ecm`.`tariff`.`thc_schedule` ADD CONSTRAINT `fk_tariff_thc_schedule_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`wharfage_schedule` ADD CONSTRAINT `fk_tariff_wharfage_schedule_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`wharfage_schedule` ADD CONSTRAINT `fk_tariff_wharfage_schedule_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`pilotage_tariff` ADD CONSTRAINT `fk_tariff_pilotage_tariff_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`pilotage_tariff` ADD CONSTRAINT `fk_tariff_pilotage_tariff_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`channel`(`channel_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`storage_tariff` ADD CONSTRAINT `fk_tariff_storage_tariff_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`storage_tariff` ADD CONSTRAINT `fk_tariff_storage_tariff_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`demurrage_schedule` ADD CONSTRAINT `fk_tariff_demurrage_schedule_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`detention_schedule` ADD CONSTRAINT `fk_tariff_detention_schedule_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`exception` ADD CONSTRAINT `fk_tariff_exception_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`exception` ADD CONSTRAINT `fk_tariff_exception_project_id` FOREIGN KEY (`project_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`project`(`project_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`pricing_rule` ADD CONSTRAINT `fk_tariff_pricing_rule_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`pricing_rule` ADD CONSTRAINT `fk_tariff_pricing_rule_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`towage_tariff` ADD CONSTRAINT `fk_tariff_towage_tariff_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`channel`(`channel_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`mooring_tariff` ADD CONSTRAINT `fk_tariff_mooring_tariff_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`port_dues_schedule` ADD CONSTRAINT `fk_tariff_port_dues_schedule_anchorage_area_id` FOREIGN KEY (`anchorage_area_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`anchorage_area`(`anchorage_area_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`port_dues_schedule` ADD CONSTRAINT `fk_tariff_port_dues_schedule_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);

-- ========= tariff --> masterdata (22 constraint(s)) =========
-- Requires: tariff schema, masterdata schema
ALTER TABLE `shipping_ports_ecm`.`tariff`.`port_tariff` ADD CONSTRAINT `fk_tariff_port_tariff_country_id` FOREIGN KEY (`country_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`port_tariff` ADD CONSTRAINT `fk_tariff_port_tariff_un_locode_id` FOREIGN KEY (`un_locode_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`un_locode`(`un_locode_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`item` ADD CONSTRAINT `fk_tariff_item_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`item` ADD CONSTRAINT `fk_tariff_item_service_code_id` FOREIGN KEY (`service_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`service_code`(`service_code_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`rate_card` ADD CONSTRAINT `fk_tariff_rate_card_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`wharfage_schedule` ADD CONSTRAINT `fk_tariff_wharfage_schedule_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`pilotage_tariff` ADD CONSTRAINT `fk_tariff_pilotage_tariff_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`pilotage_tariff` ADD CONSTRAINT `fk_tariff_pilotage_tariff_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`storage_tariff` ADD CONSTRAINT `fk_tariff_storage_tariff_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`container_type`(`container_type_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`demurrage_schedule` ADD CONSTRAINT `fk_tariff_demurrage_schedule_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`container_type`(`container_type_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`detention_schedule` ADD CONSTRAINT `fk_tariff_detention_schedule_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`container_type`(`container_type_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`towage_tariff` ADD CONSTRAINT `fk_tariff_towage_tariff_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`mooring_tariff` ADD CONSTRAINT `fk_tariff_mooring_tariff_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`port_dues_schedule` ADD CONSTRAINT `fk_tariff_port_dues_schedule_country_id` FOREIGN KEY (`country_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`port_dues_schedule` ADD CONSTRAINT `fk_tariff_port_dues_schedule_flag_state_id` FOREIGN KEY (`flag_state_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`flag_state`(`flag_state_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`applicability` ADD CONSTRAINT `fk_tariff_applicability_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`applicability` ADD CONSTRAINT `fk_tariff_applicability_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`applicability` ADD CONSTRAINT `fk_tariff_applicability_un_locode_id` FOREIGN KEY (`un_locode_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`un_locode`(`un_locode_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`applicability` ADD CONSTRAINT `fk_tariff_applicability_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`currency_adjustment` ADD CONSTRAINT `fk_tariff_currency_adjustment_country_id` FOREIGN KEY (`country_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`bunker_adjustment` ADD CONSTRAINT `fk_tariff_bunker_adjustment_country_id` FOREIGN KEY (`country_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`negotiation` ADD CONSTRAINT `fk_tariff_negotiation_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);

-- ========= tariff --> security (5 constraint(s)) =========
-- Requires: tariff schema, security schema
ALTER TABLE `shipping_ports_ecm`.`tariff`.`item` ADD CONSTRAINT `fk_tariff_item_marsec_level_change_id` FOREIGN KEY (`marsec_level_change_id`) REFERENCES `shipping_ports_ecm`.`security`.`marsec_level_change`(`marsec_level_change_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`rate_card_line` ADD CONSTRAINT `fk_tariff_rate_card_line_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`storage_tariff` ADD CONSTRAINT `fk_tariff_storage_tariff_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`exception` ADD CONSTRAINT `fk_tariff_exception_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`applicability` ADD CONSTRAINT `fk_tariff_applicability_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);

-- ========= tariff --> vessel (1 constraint(s)) =========
-- Requires: tariff schema, vessel schema
ALTER TABLE `shipping_ports_ecm`.`tariff`.`exception` ADD CONSTRAINT `fk_tariff_exception_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);

-- ========= tariff --> workforce (25 constraint(s)) =========
-- Requires: tariff schema, workforce schema
ALTER TABLE `shipping_ports_ecm`.`tariff`.`rate_card` ADD CONSTRAINT `fk_tariff_rate_card_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`rate_card_line` ADD CONSTRAINT `fk_tariff_rate_card_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`discount_scheme` ADD CONSTRAINT `fk_tariff_discount_scheme_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`sla_rate_card` ADD CONSTRAINT `fk_tariff_sla_rate_card_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`exception` ADD CONSTRAINT `fk_tariff_exception_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`exception` ADD CONSTRAINT `fk_tariff_exception_exception_employee_id` FOREIGN KEY (`exception_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`exception` ADD CONSTRAINT `fk_tariff_exception_exception_modified_by_user_employee_id` FOREIGN KEY (`exception_modified_by_user_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`exception` ADD CONSTRAINT `fk_tariff_exception_exception_revoked_by_user_employee_id` FOREIGN KEY (`exception_revoked_by_user_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`pricing_rule` ADD CONSTRAINT `fk_tariff_pricing_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`mooring_tariff` ADD CONSTRAINT `fk_tariff_mooring_tariff_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`mooring_tariff` ADD CONSTRAINT `fk_tariff_mooring_tariff_tertiary_mooring_modified_by_user_employee_id` FOREIGN KEY (`tertiary_mooring_modified_by_user_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`port_dues_schedule` ADD CONSTRAINT `fk_tariff_port_dues_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`applicability` ADD CONSTRAINT `fk_tariff_applicability_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`applicability` ADD CONSTRAINT `fk_tariff_applicability_applicability_employee_id` FOREIGN KEY (`applicability_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`applicability` ADD CONSTRAINT `fk_tariff_applicability_applicability_modified_by_user_employee_id` FOREIGN KEY (`applicability_modified_by_user_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`currency_adjustment` ADD CONSTRAINT `fk_tariff_currency_adjustment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`currency_adjustment` ADD CONSTRAINT `fk_tariff_currency_adjustment_tertiary_currency_modified_by_user_employee_id` FOREIGN KEY (`tertiary_currency_modified_by_user_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`bunker_adjustment` ADD CONSTRAINT `fk_tariff_bunker_adjustment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`filing` ADD CONSTRAINT `fk_tariff_filing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`filing` ADD CONSTRAINT `fk_tariff_filing_filing_employee_id` FOREIGN KEY (`filing_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`filing` ADD CONSTRAINT `fk_tariff_filing_filing_modified_by_user_employee_id` FOREIGN KEY (`filing_modified_by_user_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`filing` ADD CONSTRAINT `fk_tariff_filing_filing_withdrawn_by_user_employee_id` FOREIGN KEY (`filing_withdrawn_by_user_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`negotiation` ADD CONSTRAINT `fk_tariff_negotiation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`negotiation` ADD CONSTRAINT `fk_tariff_negotiation_negotiation_employee_id` FOREIGN KEY (`negotiation_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`negotiation` ADD CONSTRAINT `fk_tariff_negotiation_negotiation_modified_by_user_employee_id` FOREIGN KEY (`negotiation_modified_by_user_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= terminal --> asset (2 constraint(s)) =========
-- Requires: terminal schema, asset schema
ALTER TABLE `shipping_ports_ecm`.`terminal`.`yard_block` ADD CONSTRAINT `fk_terminal_yard_block_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_equipment` ADD CONSTRAINT `fk_terminal_terminal_equipment_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);

-- ========= terminal --> billing (10 constraint(s)) =========
-- Requires: terminal schema, billing schema
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_transaction` ADD CONSTRAINT `fk_terminal_gate_transaction_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_berth_allocation` ADD CONSTRAINT `fk_terminal_terminal_berth_allocation_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`reefer_monitoring` ADD CONSTRAINT `fk_terminal_reefer_monitoring_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_damage` ADD CONSTRAINT `fk_terminal_container_damage_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`cfs_activity` ADD CONSTRAINT `fk_terminal_cfs_activity_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_service_order` ADD CONSTRAINT `fk_terminal_terminal_service_order_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`roro_activity` ADD CONSTRAINT `fk_terminal_roro_activity_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`hazmat_declaration` ADD CONSTRAINT `fk_terminal_hazmat_declaration_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_tariff_exception_application` ADD CONSTRAINT `fk_terminal_container_tariff_exception_application_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= terminal --> booking (6 constraint(s)) =========
-- Requires: terminal schema, booking schema
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_appointment` ADD CONSTRAINT `fk_terminal_gate_appointment_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`vessel_bay_plan` ADD CONSTRAINT `fk_terminal_vessel_bay_plan_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`cfs_activity` ADD CONSTRAINT `fk_terminal_cfs_activity_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_service_order` ADD CONSTRAINT `fk_terminal_terminal_service_order_booking_service_order_id` FOREIGN KEY (`booking_service_order_id`) REFERENCES `shipping_ports_ecm`.`booking`.`booking_service_order`(`booking_service_order_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`hazmat_declaration` ADD CONSTRAINT `fk_terminal_hazmat_declaration_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);

-- ========= terminal --> cargo (6 constraint(s)) =========
-- Requires: terminal schema, cargo schema
ALTER TABLE `shipping_ports_ecm`.`terminal`.`yard_slot` ADD CONSTRAINT `fk_terminal_yard_slot_container_id` FOREIGN KEY (`container_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`container`(`container_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`reefer_monitoring` ADD CONSTRAINT `fk_terminal_reefer_monitoring_container_id` FOREIGN KEY (`container_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`container`(`container_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_damage` ADD CONSTRAINT `fk_terminal_container_damage_container_id` FOREIGN KEY (`container_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`container`(`container_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`cfs_activity` ADD CONSTRAINT `fk_terminal_cfs_activity_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`shipment`(`shipment_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_service_order` ADD CONSTRAINT `fk_terminal_terminal_service_order_container_id` FOREIGN KEY (`container_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`container`(`container_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`hazmat_declaration` ADD CONSTRAINT `fk_terminal_hazmat_declaration_container_id` FOREIGN KEY (`container_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`container`(`container_id`);

-- ========= terminal --> compliance (15 constraint(s)) =========
-- Requires: terminal schema, compliance schema
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_transaction` ADD CONSTRAINT `fk_terminal_gate_transaction_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_transaction` ADD CONSTRAINT `fk_terminal_gate_transaction_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_appointment` ADD CONSTRAINT `fk_terminal_gate_appointment_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`vessel_bay_plan` ADD CONSTRAINT `fk_terminal_vessel_bay_plan_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_berth_allocation` ADD CONSTRAINT `fk_terminal_terminal_berth_allocation_isps_facility_record_id` FOREIGN KEY (`isps_facility_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`isps_facility_record`(`isps_facility_record_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_damage` ADD CONSTRAINT `fk_terminal_container_damage_trade_document_id` FOREIGN KEY (`trade_document_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`trade_document`(`trade_document_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`cfs_activity` ADD CONSTRAINT `fk_terminal_cfs_activity_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`hs_code`(`hs_code_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`cfs_activity` ADD CONSTRAINT `fk_terminal_cfs_activity_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_service_order` ADD CONSTRAINT `fk_terminal_terminal_service_order_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`hazmat_declaration` ADD CONSTRAINT `fk_terminal_hazmat_declaration_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`hs_code`(`hs_code_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`hazmat_declaration` ADD CONSTRAINT `fk_terminal_hazmat_declaration_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`hazmat_declaration` ADD CONSTRAINT `fk_terminal_hazmat_declaration_trade_restriction_id` FOREIGN KEY (`trade_restriction_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`trade_restriction`(`trade_restriction_id`);

-- ========= terminal --> contract (3 constraint(s)) =========
-- Requires: terminal schema, contract schema
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_berth_allocation` ADD CONSTRAINT `fk_terminal_terminal_berth_allocation_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`cfs_activity` ADD CONSTRAINT `fk_terminal_cfs_activity_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_service_order` ADD CONSTRAINT `fk_terminal_terminal_service_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= terminal --> customer (8 constraint(s)) =========
-- Requires: terminal schema, customer schema
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_transaction` ADD CONSTRAINT `fk_terminal_gate_transaction_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_appointment` ADD CONSTRAINT `fk_terminal_gate_appointment_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_damage` ADD CONSTRAINT `fk_terminal_container_damage_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`cfs_activity` ADD CONSTRAINT `fk_terminal_cfs_activity_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`cfs_activity` ADD CONSTRAINT `fk_terminal_cfs_activity_tertiary_cfs_consignee_port_community_participant_id` FOREIGN KEY (`tertiary_cfs_consignee_port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_service_order` ADD CONSTRAINT `fk_terminal_terminal_service_order_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`roro_activity` ADD CONSTRAINT `fk_terminal_roro_activity_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal` ADD CONSTRAINT `fk_terminal_terminal_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);

-- ========= terminal --> finance (7 constraint(s)) =========
-- Requires: terminal schema, finance schema
ALTER TABLE `shipping_ports_ecm`.`terminal`.`yard_block` ADD CONSTRAINT `fk_terminal_yard_block_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`equipment_dispatch` ADD CONSTRAINT `fk_terminal_equipment_dispatch_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_berth_allocation` ADD CONSTRAINT `fk_terminal_terminal_berth_allocation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_berth_allocation` ADD CONSTRAINT `fk_terminal_terminal_berth_allocation_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_service_order` ADD CONSTRAINT `fk_terminal_terminal_service_order_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_equipment` ADD CONSTRAINT `fk_terminal_terminal_equipment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_equipment` ADD CONSTRAINT `fk_terminal_terminal_equipment_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `shipping_ports_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);

-- ========= terminal --> infrastructure (4 constraint(s)) =========
-- Requires: terminal schema, infrastructure schema
ALTER TABLE `shipping_ports_ecm`.`terminal`.`yard_block` ADD CONSTRAINT `fk_terminal_yard_block_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_berth_allocation` ADD CONSTRAINT `fk_terminal_terminal_berth_allocation_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_equipment` ADD CONSTRAINT `fk_terminal_terminal_equipment_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_lane` ADD CONSTRAINT `fk_terminal_gate_lane_port_gate_id` FOREIGN KEY (`port_gate_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port_gate`(`port_gate_id`);

-- ========= terminal --> intermodal (8 constraint(s)) =========
-- Requires: terminal schema, intermodal schema
ALTER TABLE `shipping_ports_ecm`.`terminal`.`yard_slot` ADD CONSTRAINT `fk_terminal_yard_slot_icd_facility_id` FOREIGN KEY (`icd_facility_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`icd_facility`(`icd_facility_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_drayage_order_id` FOREIGN KEY (`drayage_order_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`drayage_order`(`drayage_order_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_transport_order_id` FOREIGN KEY (`transport_order_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`transport_order`(`transport_order_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_transaction` ADD CONSTRAINT `fk_terminal_gate_transaction_truck_appointment_id` FOREIGN KEY (`truck_appointment_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`truck_appointment`(`truck_appointment_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`equipment_dispatch` ADD CONSTRAINT `fk_terminal_equipment_dispatch_rail_visit_id` FOREIGN KEY (`rail_visit_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`rail_visit`(`rail_visit_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`vessel_bay_plan` ADD CONSTRAINT `fk_terminal_vessel_bay_plan_edi_message_id` FOREIGN KEY (`edi_message_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`edi_message`(`edi_message_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`vessel_bay_plan` ADD CONSTRAINT `fk_terminal_vessel_bay_plan_rail_visit_id` FOREIGN KEY (`rail_visit_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`rail_visit`(`rail_visit_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_berth_allocation` ADD CONSTRAINT `fk_terminal_terminal_berth_allocation_service_id` FOREIGN KEY (`service_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`service`(`service_id`);

-- ========= terminal --> marine (2 constraint(s)) =========
-- Requires: terminal schema, marine schema
ALTER TABLE `shipping_ports_ecm`.`terminal`.`vessel_bay_plan` ADD CONSTRAINT `fk_terminal_vessel_bay_plan_pilotage_assignment_id` FOREIGN KEY (`pilotage_assignment_id`) REFERENCES `shipping_ports_ecm`.`marine`.`pilotage_assignment`(`pilotage_assignment_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_damage` ADD CONSTRAINT `fk_terminal_container_damage_surveyor_id` FOREIGN KEY (`surveyor_id`) REFERENCES `shipping_ports_ecm`.`marine`.`surveyor`(`surveyor_id`);

-- ========= terminal --> masterdata (12 constraint(s)) =========
-- Requires: terminal schema, masterdata schema
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`container_type`(`container_type_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_berth_allocation` ADD CONSTRAINT `fk_terminal_terminal_berth_allocation_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`reefer_monitoring` ADD CONSTRAINT `fk_terminal_reefer_monitoring_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_damage` ADD CONSTRAINT `fk_terminal_container_damage_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`cfs_activity` ADD CONSTRAINT `fk_terminal_cfs_activity_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`cfs_activity` ADD CONSTRAINT `fk_terminal_cfs_activity_packaging_type_id` FOREIGN KEY (`packaging_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`packaging_type`(`packaging_type_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_service_order` ADD CONSTRAINT `fk_terminal_terminal_service_order_service_code_id` FOREIGN KEY (`service_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`service_code`(`service_code_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_equipment` ADD CONSTRAINT `fk_terminal_terminal_equipment_equipment_type_id` FOREIGN KEY (`equipment_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`equipment_type`(`equipment_type_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`hazmat_declaration` ADD CONSTRAINT `fk_terminal_hazmat_declaration_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`hazmat_declaration` ADD CONSTRAINT `fk_terminal_hazmat_declaration_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal` ADD CONSTRAINT `fk_terminal_terminal_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);

-- ========= terminal --> procurement (6 constraint(s)) =========
-- Requires: terminal schema, procurement schema
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_damage` ADD CONSTRAINT `fk_terminal_container_damage_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_service_order` ADD CONSTRAINT `fk_terminal_terminal_service_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_service_order` ADD CONSTRAINT `fk_terminal_terminal_service_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_equipment` ADD CONSTRAINT `fk_terminal_terminal_equipment_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_equipment` ADD CONSTRAINT `fk_terminal_terminal_equipment_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_equipment` ADD CONSTRAINT `fk_terminal_terminal_equipment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= terminal --> safety (8 constraint(s)) =========
-- Requires: terminal schema, safety schema
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_ohs_incident_id` FOREIGN KEY (`ohs_incident_id`) REFERENCES `shipping_ports_ecm`.`safety`.`ohs_incident`(`ohs_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_transaction` ADD CONSTRAINT `fk_terminal_gate_transaction_ohs_incident_id` FOREIGN KEY (`ohs_incident_id`) REFERENCES `shipping_ports_ecm`.`safety`.`ohs_incident`(`ohs_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`equipment_dispatch` ADD CONSTRAINT `fk_terminal_equipment_dispatch_ohs_incident_id` FOREIGN KEY (`ohs_incident_id`) REFERENCES `shipping_ports_ecm`.`safety`.`ohs_incident`(`ohs_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_berth_allocation` ADD CONSTRAINT `fk_terminal_terminal_berth_allocation_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `shipping_ports_ecm`.`safety`.`inspection`(`inspection_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_damage` ADD CONSTRAINT `fk_terminal_container_damage_ohs_incident_id` FOREIGN KEY (`ohs_incident_id`) REFERENCES `shipping_ports_ecm`.`safety`.`ohs_incident`(`ohs_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_service_order` ADD CONSTRAINT `fk_terminal_terminal_service_order_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `shipping_ports_ecm`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`roro_activity` ADD CONSTRAINT `fk_terminal_roro_activity_ohs_incident_id` FOREIGN KEY (`ohs_incident_id`) REFERENCES `shipping_ports_ecm`.`safety`.`ohs_incident`(`ohs_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`hazmat_declaration` ADD CONSTRAINT `fk_terminal_hazmat_declaration_hazard_register_id` FOREIGN KEY (`hazard_register_id`) REFERENCES `shipping_ports_ecm`.`safety`.`hazard_register`(`hazard_register_id`);

-- ========= terminal --> security (11 constraint(s)) =========
-- Requires: terminal schema, security schema
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_transaction` ADD CONSTRAINT `fk_terminal_gate_transaction_screening_record_id` FOREIGN KEY (`screening_record_id`) REFERENCES `shipping_ports_ecm`.`security`.`screening_record`(`screening_record_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_appointment` ADD CONSTRAINT `fk_terminal_gate_appointment_access_credential_id` FOREIGN KEY (`access_credential_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_credential`(`access_credential_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`equipment_dispatch` ADD CONSTRAINT `fk_terminal_equipment_dispatch_access_credential_id` FOREIGN KEY (`access_credential_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_credential`(`access_credential_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`vessel_bay_plan` ADD CONSTRAINT `fk_terminal_vessel_bay_plan_personnel_id` FOREIGN KEY (`personnel_id`) REFERENCES `shipping_ports_ecm`.`security`.`personnel`(`personnel_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_berth_allocation` ADD CONSTRAINT `fk_terminal_terminal_berth_allocation_dos_record_id` FOREIGN KEY (`dos_record_id`) REFERENCES `shipping_ports_ecm`.`security`.`dos_record`(`dos_record_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_damage` ADD CONSTRAINT `fk_terminal_container_damage_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_service_order` ADD CONSTRAINT `fk_terminal_terminal_service_order_access_credential_id` FOREIGN KEY (`access_credential_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_credential`(`access_credential_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_equipment` ADD CONSTRAINT `fk_terminal_terminal_equipment_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`roro_activity` ADD CONSTRAINT `fk_terminal_roro_activity_screening_record_id` FOREIGN KEY (`screening_record_id`) REFERENCES `shipping_ports_ecm`.`security`.`screening_record`(`screening_record_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`hazmat_declaration` ADD CONSTRAINT `fk_terminal_hazmat_declaration_threat_assessment_id` FOREIGN KEY (`threat_assessment_id`) REFERENCES `shipping_ports_ecm`.`security`.`threat_assessment`(`threat_assessment_id`);

-- ========= terminal --> tariff (11 constraint(s)) =========
-- Requires: terminal schema, tariff schema
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_demurrage_schedule_id` FOREIGN KEY (`demurrage_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`demurrage_schedule`(`demurrage_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_storage_tariff_id` FOREIGN KEY (`storage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`storage_tariff`(`storage_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`equipment_dispatch` ADD CONSTRAINT `fk_terminal_equipment_dispatch_thc_schedule_id` FOREIGN KEY (`thc_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`thc_schedule`(`thc_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_berth_allocation` ADD CONSTRAINT `fk_terminal_terminal_berth_allocation_port_dues_schedule_id` FOREIGN KEY (`port_dues_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_dues_schedule`(`port_dues_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_berth_allocation` ADD CONSTRAINT `fk_terminal_terminal_berth_allocation_wharfage_schedule_id` FOREIGN KEY (`wharfage_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`wharfage_schedule`(`wharfage_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`cfs_activity` ADD CONSTRAINT `fk_terminal_cfs_activity_item_id` FOREIGN KEY (`item_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`item`(`item_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_service_order` ADD CONSTRAINT `fk_terminal_terminal_service_order_item_id` FOREIGN KEY (`item_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`item`(`item_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`roro_activity` ADD CONSTRAINT `fk_terminal_roro_activity_wharfage_schedule_id` FOREIGN KEY (`wharfage_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`wharfage_schedule`(`wharfage_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`hazmat_declaration` ADD CONSTRAINT `fk_terminal_hazmat_declaration_surcharge_rule_id` FOREIGN KEY (`surcharge_rule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`surcharge_rule`(`surcharge_rule_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_tariff_exception_application` ADD CONSTRAINT `fk_terminal_container_tariff_exception_application_exception_id` FOREIGN KEY (`exception_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`exception`(`exception_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`berth_discount_application` ADD CONSTRAINT `fk_terminal_berth_discount_application_discount_scheme_id` FOREIGN KEY (`discount_scheme_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`discount_scheme`(`discount_scheme_id`);

-- ========= terminal --> vessel (6 constraint(s)) =========
-- Requires: terminal schema, vessel schema
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_appointment` ADD CONSTRAINT `fk_terminal_gate_appointment_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`equipment_dispatch` ADD CONSTRAINT `fk_terminal_equipment_dispatch_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`vessel_bay_plan` ADD CONSTRAINT `fk_terminal_vessel_bay_plan_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_berth_allocation` ADD CONSTRAINT `fk_terminal_terminal_berth_allocation_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`roro_activity` ADD CONSTRAINT `fk_terminal_roro_activity_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);

-- ========= terminal --> workforce (21 constraint(s)) =========
-- Requires: terminal schema, workforce schema
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_transaction` ADD CONSTRAINT `fk_terminal_gate_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_transaction` ADD CONSTRAINT `fk_terminal_gate_transaction_shift_pattern_id` FOREIGN KEY (`shift_pattern_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`shift_pattern`(`shift_pattern_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_appointment` ADD CONSTRAINT `fk_terminal_gate_appointment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`equipment_dispatch` ADD CONSTRAINT `fk_terminal_equipment_dispatch_gang_id` FOREIGN KEY (`gang_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`gang`(`gang_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`equipment_dispatch` ADD CONSTRAINT `fk_terminal_equipment_dispatch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`vessel_bay_plan` ADD CONSTRAINT `fk_terminal_vessel_bay_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_berth_allocation` ADD CONSTRAINT `fk_terminal_terminal_berth_allocation_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_berth_allocation` ADD CONSTRAINT `fk_terminal_terminal_berth_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_berth_allocation` ADD CONSTRAINT `fk_terminal_terminal_berth_allocation_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`reefer_monitoring` ADD CONSTRAINT `fk_terminal_reefer_monitoring_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_damage` ADD CONSTRAINT `fk_terminal_container_damage_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`cfs_activity` ADD CONSTRAINT `fk_terminal_cfs_activity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`cfs_activity` ADD CONSTRAINT `fk_terminal_cfs_activity_shift_pattern_id` FOREIGN KEY (`shift_pattern_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`shift_pattern`(`shift_pattern_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_service_order` ADD CONSTRAINT `fk_terminal_terminal_service_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_service_order` ADD CONSTRAINT `fk_terminal_terminal_service_order_shift_pattern_id` FOREIGN KEY (`shift_pattern_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`shift_pattern`(`shift_pattern_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_equipment` ADD CONSTRAINT `fk_terminal_terminal_equipment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`roro_activity` ADD CONSTRAINT `fk_terminal_roro_activity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`roro_activity` ADD CONSTRAINT `fk_terminal_roro_activity_shift_pattern_id` FOREIGN KEY (`shift_pattern_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`shift_pattern`(`shift_pattern_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`hazmat_declaration` ADD CONSTRAINT `fk_terminal_hazmat_declaration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_tariff_exception_application` ADD CONSTRAINT `fk_terminal_container_tariff_exception_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`berth_discount_application` ADD CONSTRAINT `fk_terminal_berth_discount_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= vessel --> asset (3 constraint(s)) =========
-- Requires: vessel schema, asset schema
ALTER TABLE `shipping_ports_ecm`.`vessel`.`call` ADD CONSTRAINT `fk_vessel_call_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`waste_declaration` ADD CONSTRAINT `fk_vessel_waste_declaration_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`bunker_operation` ADD CONSTRAINT `fk_vessel_bunker_operation_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);

-- ========= vessel --> billing (1 constraint(s)) =========
-- Requires: vessel schema, billing schema
ALTER TABLE `shipping_ports_ecm`.`vessel`.`owner` ADD CONSTRAINT `fk_vessel_owner_receivable_account_id` FOREIGN KEY (`receivable_account_id`) REFERENCES `shipping_ports_ecm`.`billing`.`receivable_account`(`receivable_account_id`);

-- ========= vessel --> compliance (6 constraint(s)) =========
-- Requires: vessel schema, compliance schema
ALTER TABLE `shipping_ports_ecm`.`vessel`.`call_document` ADD CONSTRAINT `fk_vessel_call_document_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`certificate` ADD CONSTRAINT `fk_vessel_certificate_compliance_audit_id` FOREIGN KEY (`compliance_audit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`compliance_audit`(`compliance_audit_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`psc_inspection` ADD CONSTRAINT `fk_vessel_psc_inspection_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`agent_appointment` ADD CONSTRAINT `fk_vessel_agent_appointment_customs_broker_id` FOREIGN KEY (`customs_broker_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_broker`(`customs_broker_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`waste_declaration` ADD CONSTRAINT `fk_vessel_waste_declaration_marpol_record_id` FOREIGN KEY (`marpol_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`marpol_record`(`marpol_record_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`isps_record` ADD CONSTRAINT `fk_vessel_isps_record_isps_facility_record_id` FOREIGN KEY (`isps_facility_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`isps_facility_record`(`isps_facility_record_id`);

-- ========= vessel --> contract (5 constraint(s)) =========
-- Requires: vessel schema, contract schema
ALTER TABLE `shipping_ports_ecm`.`vessel`.`call` ADD CONSTRAINT `fk_vessel_call_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`voyage` ADD CONSTRAINT `fk_vessel_voyage_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`agent_appointment` ADD CONSTRAINT `fk_vessel_agent_appointment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`service_route` ADD CONSTRAINT `fk_vessel_service_route_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`bunker_operation` ADD CONSTRAINT `fk_vessel_bunker_operation_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `shipping_ports_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= vessel --> customer (5 constraint(s)) =========
-- Requires: vessel schema, customer schema
ALTER TABLE `shipping_ports_ecm`.`vessel`.`owner` ADD CONSTRAINT `fk_vessel_owner_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`call` ADD CONSTRAINT `fk_vessel_call_contact_person_id` FOREIGN KEY (`contact_person_id`) REFERENCES `shipping_ports_ecm`.`customer`.`contact_person`(`contact_person_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`agent_appointment` ADD CONSTRAINT `fk_vessel_agent_appointment_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`waste_declaration` ADD CONSTRAINT `fk_vessel_waste_declaration_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`agency_appointment` ADD CONSTRAINT `fk_vessel_agency_appointment_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);

-- ========= vessel --> finance (9 constraint(s)) =========
-- Requires: vessel schema, finance schema
ALTER TABLE `shipping_ports_ecm`.`vessel`.`call` ADD CONSTRAINT `fk_vessel_call_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`call` ADD CONSTRAINT `fk_vessel_call_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`anchorage` ADD CONSTRAINT `fk_vessel_anchorage_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`movement` ADD CONSTRAINT `fk_vessel_movement_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`psc_inspection` ADD CONSTRAINT `fk_vessel_psc_inspection_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`agent_appointment` ADD CONSTRAINT `fk_vessel_agent_appointment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`draft_survey` ADD CONSTRAINT `fk_vessel_draft_survey_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`waste_declaration` ADD CONSTRAINT `fk_vessel_waste_declaration_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`bunker_operation` ADD CONSTRAINT `fk_vessel_bunker_operation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);

-- ========= vessel --> infrastructure (7 constraint(s)) =========
-- Requires: vessel schema, infrastructure schema
ALTER TABLE `shipping_ports_ecm`.`vessel`.`call` ADD CONSTRAINT `fk_vessel_call_anchorage_area_id` FOREIGN KEY (`anchorage_area_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`anchorage_area`(`anchorage_area_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`call` ADD CONSTRAINT `fk_vessel_call_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`anchorage` ADD CONSTRAINT `fk_vessel_anchorage_anchorage_area_id` FOREIGN KEY (`anchorage_area_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`anchorage_area`(`anchorage_area_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`anchorage` ADD CONSTRAINT `fk_vessel_anchorage_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`service_route` ADD CONSTRAINT `fk_vessel_service_route_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`bunker_operation` ADD CONSTRAINT `fk_vessel_bunker_operation_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`port_call` ADD CONSTRAINT `fk_vessel_port_call_infrastructure_berth_allocation_id` FOREIGN KEY (`infrastructure_berth_allocation_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`infrastructure_berth_allocation`(`infrastructure_berth_allocation_id`);

-- ========= vessel --> intermodal (1 constraint(s)) =========
-- Requires: vessel schema, intermodal schema
ALTER TABLE `shipping_ports_ecm`.`vessel`.`call_icd_allocation` ADD CONSTRAINT `fk_vessel_call_icd_allocation_icd_facility_id` FOREIGN KEY (`icd_facility_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`icd_facility`(`icd_facility_id`);

-- ========= vessel --> marine (4 constraint(s)) =========
-- Requires: vessel schema, marine schema
ALTER TABLE `shipping_ports_ecm`.`vessel`.`movement` ADD CONSTRAINT `fk_vessel_movement_pilot_id` FOREIGN KEY (`pilot_id`) REFERENCES `shipping_ports_ecm`.`marine`.`pilot`(`pilot_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`vts_log` ADD CONSTRAINT `fk_vessel_vts_log_marine_incident_id` FOREIGN KEY (`marine_incident_id`) REFERENCES `shipping_ports_ecm`.`marine`.`marine_incident`(`marine_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`vts_log` ADD CONSTRAINT `fk_vessel_vts_log_pilot_id` FOREIGN KEY (`pilot_id`) REFERENCES `shipping_ports_ecm`.`marine`.`pilot`(`pilot_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`certificate` ADD CONSTRAINT `fk_vessel_certificate_marine_incident_id` FOREIGN KEY (`marine_incident_id`) REFERENCES `shipping_ports_ecm`.`marine`.`marine_incident`(`marine_incident_id`);

-- ========= vessel --> masterdata (11 constraint(s)) =========
-- Requires: vessel schema, masterdata schema
ALTER TABLE `shipping_ports_ecm`.`vessel`.`vessel` ADD CONSTRAINT `fk_vessel_vessel_flag_state_id` FOREIGN KEY (`flag_state_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`flag_state`(`flag_state_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`vessel` ADD CONSTRAINT `fk_vessel_vessel_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`vessel` ADD CONSTRAINT `fk_vessel_vessel_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`voyage` ADD CONSTRAINT `fk_vessel_voyage_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`call_document` ADD CONSTRAINT `fk_vessel_call_document_un_locode_id` FOREIGN KEY (`un_locode_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`un_locode`(`un_locode_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`certificate` ADD CONSTRAINT `fk_vessel_certificate_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`psc_inspection` ADD CONSTRAINT `fk_vessel_psc_inspection_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`crew_list` ADD CONSTRAINT `fk_vessel_crew_list_country_id` FOREIGN KEY (`country_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`waste_declaration` ADD CONSTRAINT `fk_vessel_waste_declaration_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`charter` ADD CONSTRAINT `fk_vessel_charter_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`port_call` ADD CONSTRAINT `fk_vessel_port_call_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);

-- ========= vessel --> procurement (4 constraint(s)) =========
-- Requires: vessel schema, procurement schema
ALTER TABLE `shipping_ports_ecm`.`vessel`.`call` ADD CONSTRAINT `fk_vessel_call_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`waste_declaration` ADD CONSTRAINT `fk_vessel_waste_declaration_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`bunker_operation` ADD CONSTRAINT `fk_vessel_bunker_operation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`service_agreement` ADD CONSTRAINT `fk_vessel_service_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `shipping_ports_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= vessel --> safety (10 constraint(s)) =========
-- Requires: vessel schema, safety schema
ALTER TABLE `shipping_ports_ecm`.`vessel`.`anchorage` ADD CONSTRAINT `fk_vessel_anchorage_ohs_incident_id` FOREIGN KEY (`ohs_incident_id`) REFERENCES `shipping_ports_ecm`.`safety`.`ohs_incident`(`ohs_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`movement` ADD CONSTRAINT `fk_vessel_movement_ohs_incident_id` FOREIGN KEY (`ohs_incident_id`) REFERENCES `shipping_ports_ecm`.`safety`.`ohs_incident`(`ohs_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`agent_appointment` ADD CONSTRAINT `fk_vessel_agent_appointment_contractor_safety_id` FOREIGN KEY (`contractor_safety_id`) REFERENCES `shipping_ports_ecm`.`safety`.`contractor_safety`(`contractor_safety_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`draft_survey` ADD CONSTRAINT `fk_vessel_draft_survey_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `shipping_ports_ecm`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`crew_list` ADD CONSTRAINT `fk_vessel_crew_list_ohs_incident_id` FOREIGN KEY (`ohs_incident_id`) REFERENCES `shipping_ports_ecm`.`safety`.`ohs_incident`(`ohs_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`isps_record` ADD CONSTRAINT `fk_vessel_isps_record_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `shipping_ports_ecm`.`safety`.`inspection`(`inspection_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`bunker_operation` ADD CONSTRAINT `fk_vessel_bunker_operation_ohs_incident_id` FOREIGN KEY (`ohs_incident_id`) REFERENCES `shipping_ports_ecm`.`safety`.`ohs_incident`(`ohs_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`bunker_operation` ADD CONSTRAINT `fk_vessel_bunker_operation_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `shipping_ports_ecm`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`call_inspection` ADD CONSTRAINT `fk_vessel_call_inspection_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `shipping_ports_ecm`.`safety`.`inspection`(`inspection_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`call_inspection` ADD CONSTRAINT `fk_vessel_call_inspection_safety_inspection_id` FOREIGN KEY (`safety_inspection_id`) REFERENCES `shipping_ports_ecm`.`safety`.`inspection`(`inspection_id`);

-- ========= vessel --> security (7 constraint(s)) =========
-- Requires: vessel schema, security schema
ALTER TABLE `shipping_ports_ecm`.`vessel`.`certificate` ADD CONSTRAINT `fk_vessel_certificate_security_audit_id` FOREIGN KEY (`security_audit_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_audit`(`security_audit_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`psc_inspection` ADD CONSTRAINT `fk_vessel_psc_inspection_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`agent_appointment` ADD CONSTRAINT `fk_vessel_agent_appointment_access_credential_id` FOREIGN KEY (`access_credential_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_credential`(`access_credential_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`crew_list` ADD CONSTRAINT `fk_vessel_crew_list_access_credential_id` FOREIGN KEY (`access_credential_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_credential`(`access_credential_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`crew_list` ADD CONSTRAINT `fk_vessel_crew_list_visitor_log_id` FOREIGN KEY (`visitor_log_id`) REFERENCES `shipping_ports_ecm`.`security`.`visitor_log`(`visitor_log_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`waste_declaration` ADD CONSTRAINT `fk_vessel_waste_declaration_screening_record_id` FOREIGN KEY (`screening_record_id`) REFERENCES `shipping_ports_ecm`.`security`.`screening_record`(`screening_record_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`isps_record` ADD CONSTRAINT `fk_vessel_isps_record_facility_security_plan_id` FOREIGN KEY (`facility_security_plan_id`) REFERENCES `shipping_ports_ecm`.`security`.`facility_security_plan`(`facility_security_plan_id`);

-- ========= vessel --> tariff (6 constraint(s)) =========
-- Requires: vessel schema, tariff schema
ALTER TABLE `shipping_ports_ecm`.`vessel`.`call` ADD CONSTRAINT `fk_vessel_call_port_tariff_id` FOREIGN KEY (`port_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_tariff`(`port_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`call` ADD CONSTRAINT `fk_vessel_call_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`voyage` ADD CONSTRAINT `fk_vessel_voyage_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`anchorage` ADD CONSTRAINT `fk_vessel_anchorage_port_tariff_id` FOREIGN KEY (`port_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_tariff`(`port_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`draft_survey` ADD CONSTRAINT `fk_vessel_draft_survey_wharfage_schedule_id` FOREIGN KEY (`wharfage_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`wharfage_schedule`(`wharfage_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`bunker_operation` ADD CONSTRAINT `fk_vessel_bunker_operation_bunker_adjustment_id` FOREIGN KEY (`bunker_adjustment_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`bunker_adjustment`(`bunker_adjustment_id`);

-- ========= vessel --> terminal (2 constraint(s)) =========
-- Requires: vessel schema, terminal schema
ALTER TABLE `shipping_ports_ecm`.`vessel`.`anchorage` ADD CONSTRAINT `fk_vessel_anchorage_terminal_berth_allocation_id` FOREIGN KEY (`terminal_berth_allocation_id`) REFERENCES `shipping_ports_ecm`.`terminal`.`terminal_berth_allocation`(`terminal_berth_allocation_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`vts_log` ADD CONSTRAINT `fk_vessel_vts_log_terminal_berth_allocation_id` FOREIGN KEY (`terminal_berth_allocation_id`) REFERENCES `shipping_ports_ecm`.`terminal`.`terminal_berth_allocation`(`terminal_berth_allocation_id`);

-- ========= vessel --> workforce (15 constraint(s)) =========
-- Requires: vessel schema, workforce schema
ALTER TABLE `shipping_ports_ecm`.`vessel`.`voyage` ADD CONSTRAINT `fk_vessel_voyage_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`anchorage` ADD CONSTRAINT `fk_vessel_anchorage_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`anchorage` ADD CONSTRAINT `fk_vessel_anchorage_anchorage_vts_officer_employee_id` FOREIGN KEY (`anchorage_vts_officer_employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`movement` ADD CONSTRAINT `fk_vessel_movement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`vts_log` ADD CONSTRAINT `fk_vessel_vts_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`call_document` ADD CONSTRAINT `fk_vessel_call_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`certificate` ADD CONSTRAINT `fk_vessel_certificate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`psc_inspection` ADD CONSTRAINT `fk_vessel_psc_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`agent_appointment` ADD CONSTRAINT `fk_vessel_agent_appointment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`draft_survey` ADD CONSTRAINT `fk_vessel_draft_survey_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`waste_declaration` ADD CONSTRAINT `fk_vessel_waste_declaration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`isps_record` ADD CONSTRAINT `fk_vessel_isps_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`bunker_operation` ADD CONSTRAINT `fk_vessel_bunker_operation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`deployment` ADD CONSTRAINT `fk_vessel_deployment_gang_id` FOREIGN KEY (`gang_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`gang`(`gang_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`call_assignment` ADD CONSTRAINT `fk_vessel_call_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `shipping_ports_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= workforce --> asset (3 constraint(s)) =========
-- Requires: workforce schema, asset schema
ALTER TABLE `shipping_ports_ecm`.`workforce`.`gang_assignment` ADD CONSTRAINT `fk_workforce_gang_assignment_port_asset_id` FOREIGN KEY (`port_asset_id`) REFERENCES `shipping_ports_ecm`.`asset`.`port_asset`(`port_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`workforce`.`gang_assignment` ADD CONSTRAINT `fk_workforce_gang_assignment_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `shipping_ports_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `shipping_ports_ecm`.`workforce`.`calibration_session` ADD CONSTRAINT `fk_workforce_calibration_session_location_id` FOREIGN KEY (`location_id`) REFERENCES `shipping_ports_ecm`.`asset`.`location`(`location_id`);

-- ========= workforce --> infrastructure (7 constraint(s)) =========
-- Requires: workforce schema, infrastructure schema
ALTER TABLE `shipping_ports_ecm`.`workforce`.`gang` ADD CONSTRAINT `fk_workforce_gang_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`workforce`.`gang_assignment` ADD CONSTRAINT `fk_workforce_gang_assignment_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`workforce`.`roster` ADD CONSTRAINT `fk_workforce_roster_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`workforce`.`time_attendance` ADD CONSTRAINT `fk_workforce_time_attendance_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`workforce`.`time_attendance` ADD CONSTRAINT `fk_workforce_time_attendance_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`workforce`.`employee_certification` ADD CONSTRAINT `fk_workforce_employee_certification_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);

-- ========= workforce --> intermodal (1 constraint(s)) =========
-- Requires: workforce schema, intermodal schema
ALTER TABLE `shipping_ports_ecm`.`workforce`.`gang_assignment` ADD CONSTRAINT `fk_workforce_gang_assignment_rail_visit_id` FOREIGN KEY (`rail_visit_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`rail_visit`(`rail_visit_id`);

-- ========= workforce --> marine (1 constraint(s)) =========
-- Requires: workforce schema, marine schema
ALTER TABLE `shipping_ports_ecm`.`workforce`.`pilot_licence` ADD CONSTRAINT `fk_workforce_pilot_licence_pilot_id` FOREIGN KEY (`pilot_id`) REFERENCES `shipping_ports_ecm`.`marine`.`pilot`(`pilot_id`);

-- ========= workforce --> masterdata (20 constraint(s)) =========
-- Requires: workforce schema, masterdata schema
ALTER TABLE `shipping_ports_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`workforce`.`gang` ADD CONSTRAINT `fk_workforce_gang_equipment_type_id` FOREIGN KEY (`equipment_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`equipment_type`(`equipment_type_id`);
ALTER TABLE `shipping_ports_ecm`.`workforce`.`gang` ADD CONSTRAINT `fk_workforce_gang_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`workforce`.`gang` ADD CONSTRAINT `fk_workforce_gang_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`workforce`.`gang_assignment` ADD CONSTRAINT `fk_workforce_gang_assignment_equipment_type_id` FOREIGN KEY (`equipment_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`equipment_type`(`equipment_type_id`);
ALTER TABLE `shipping_ports_ecm`.`workforce`.`shift_pattern` ADD CONSTRAINT `fk_workforce_shift_pattern_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`workforce`.`roster` ADD CONSTRAINT `fk_workforce_roster_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`workforce`.`time_attendance` ADD CONSTRAINT `fk_workforce_time_attendance_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`workforce`.`competency` ADD CONSTRAINT `fk_workforce_competency_equipment_type_id` FOREIGN KEY (`equipment_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`equipment_type`(`equipment_type_id`);
ALTER TABLE `shipping_ports_ecm`.`workforce`.`competency` ADD CONSTRAINT `fk_workforce_competency_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);
ALTER TABLE `shipping_ports_ecm`.`workforce`.`competency` ADD CONSTRAINT `fk_workforce_competency_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_equipment_type_id` FOREIGN KEY (`equipment_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`equipment_type`(`equipment_type_id`);
ALTER TABLE `shipping_ports_ecm`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);
ALTER TABLE `shipping_ports_ecm`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`workforce`.`labour_agreement` ADD CONSTRAINT `fk_workforce_labour_agreement_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`workforce`.`pilot_licence` ADD CONSTRAINT `fk_workforce_pilot_licence_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`workforce`.`pilot_licence` ADD CONSTRAINT `fk_workforce_pilot_licence_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);

-- ========= workforce --> vessel (3 constraint(s)) =========
-- Requires: workforce schema, vessel schema
ALTER TABLE `shipping_ports_ecm`.`workforce`.`gang_assignment` ADD CONSTRAINT `fk_workforce_gang_assignment_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`workforce`.`roster` ADD CONSTRAINT `fk_workforce_roster_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`workforce`.`time_attendance` ADD CONSTRAINT `fk_workforce_time_attendance_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);

