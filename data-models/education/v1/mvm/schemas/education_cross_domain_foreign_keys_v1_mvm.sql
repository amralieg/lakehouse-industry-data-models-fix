-- Cross-Domain Foreign Keys for Business: Education | Version: v1_mvm
-- Generated on: 2026-05-06 15:14:04
-- Total cross-domain FK constraints: 1027
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: advancement, aid, billing, compliance, curriculum, enrollment, facility, faculty, finance, hr, instruction, research, student, studentlife

-- ========= advancement --> aid (5 constraint(s)) =========
-- Requires: advancement schema, aid schema
ALTER TABLE `education_ecm`.`advancement`.`gift` ADD CONSTRAINT `fk_advancement_gift_scholarship_id` FOREIGN KEY (`scholarship_id`) REFERENCES `education_ecm`.`aid`.`scholarship`(`scholarship_id`);
ALTER TABLE `education_ecm`.`advancement`.`pledge` ADD CONSTRAINT `fk_advancement_pledge_scholarship_id` FOREIGN KEY (`scholarship_id`) REFERENCES `education_ecm`.`aid`.`scholarship`(`scholarship_id`);
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ADD CONSTRAINT `fk_advancement_major_gift_proposal_scholarship_id` FOREIGN KEY (`scholarship_id`) REFERENCES `education_ecm`.`aid`.`scholarship`(`scholarship_id`);
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ADD CONSTRAINT `fk_advancement_planned_gift_scholarship_id` FOREIGN KEY (`scholarship_id`) REFERENCES `education_ecm`.`aid`.`scholarship`(`scholarship_id`);
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ADD CONSTRAINT `fk_advancement_stewardship_action_scholarship_id` FOREIGN KEY (`scholarship_id`) REFERENCES `education_ecm`.`aid`.`scholarship`(`scholarship_id`);

-- ========= advancement --> billing (2 constraint(s)) =========
-- Requires: advancement schema, billing schema
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ADD CONSTRAINT `fk_advancement_alumni_event_registration_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `education_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ADD CONSTRAINT `fk_advancement_alumni_event_registration_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);

-- ========= advancement --> compliance (8 constraint(s)) =========
-- Requires: advancement schema, compliance schema
ALTER TABLE `education_ecm`.`advancement`.`campaign` ADD CONSTRAINT `fk_advancement_campaign_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ADD CONSTRAINT `fk_advancement_advancement_fund_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ADD CONSTRAINT `fk_advancement_major_gift_proposal_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ADD CONSTRAINT `fk_advancement_major_gift_proposal_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ADD CONSTRAINT `fk_advancement_planned_gift_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ADD CONSTRAINT `fk_advancement_planned_gift_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ADD CONSTRAINT `fk_advancement_stewardship_action_ferpa_disclosure_id` FOREIGN KEY (`ferpa_disclosure_id`) REFERENCES `education_ecm`.`compliance`.`ferpa_disclosure`(`ferpa_disclosure_id`);
ALTER TABLE `education_ecm`.`advancement`.`endowment` ADD CONSTRAINT `fk_advancement_endowment_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= advancement --> curriculum (7 constraint(s)) =========
-- Requires: advancement schema, curriculum schema
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ADD CONSTRAINT `fk_advancement_alumnus_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ADD CONSTRAINT `fk_advancement_alumnus_cip_code_id` FOREIGN KEY (`cip_code_id`) REFERENCES `education_ecm`.`curriculum`.`cip_code`(`cip_code_id`);
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ADD CONSTRAINT `fk_advancement_alumni_event_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ADD CONSTRAINT `fk_advancement_advancement_fund_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ADD CONSTRAINT `fk_advancement_major_gift_proposal_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ADD CONSTRAINT `fk_advancement_planned_gift_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`advancement`.`endowment` ADD CONSTRAINT `fk_advancement_endowment_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);

-- ========= advancement --> enrollment (3 constraint(s)) =========
-- Requires: advancement schema, enrollment schema
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ADD CONSTRAINT `fk_advancement_alumnus_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ADD CONSTRAINT `fk_advancement_alumni_event_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`advancement`.`endowment` ADD CONSTRAINT `fk_advancement_endowment_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);

-- ========= advancement --> facility (6 constraint(s)) =========
-- Requires: advancement schema, facility schema
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ADD CONSTRAINT `fk_advancement_alumni_event_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ADD CONSTRAINT `fk_advancement_advancement_fund_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ADD CONSTRAINT `fk_advancement_major_gift_proposal_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`advancement`.`endowment` ADD CONSTRAINT `fk_advancement_endowment_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`advancement`.`event` ADD CONSTRAINT `fk_advancement_event_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`advancement`.`event` ADD CONSTRAINT `fk_advancement_event_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);

-- ========= advancement --> finance (27 constraint(s)) =========
-- Requires: advancement schema, finance schema
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ADD CONSTRAINT `fk_advancement_engagement_activity_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ADD CONSTRAINT `fk_advancement_alumni_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ADD CONSTRAINT `fk_advancement_alumni_event_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ADD CONSTRAINT `fk_advancement_alumni_event_registration_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`gift` ADD CONSTRAINT `fk_advancement_gift_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `education_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `education_ecm`.`advancement`.`gift` ADD CONSTRAINT `fk_advancement_gift_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`gift` ADD CONSTRAINT `fk_advancement_gift_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`advancement`.`pledge` ADD CONSTRAINT `fk_advancement_pledge_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`pledge` ADD CONSTRAINT `fk_advancement_pledge_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`advancement`.`campaign` ADD CONSTRAINT `fk_advancement_campaign_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`advancement`.`campaign` ADD CONSTRAINT `fk_advancement_campaign_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`advancement`.`campaign` ADD CONSTRAINT `fk_advancement_campaign_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ADD CONSTRAINT `fk_advancement_advancement_fund_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ADD CONSTRAINT `fk_advancement_advancement_fund_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ADD CONSTRAINT `fk_advancement_advancement_fund_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ADD CONSTRAINT `fk_advancement_advancement_fund_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`advancement`.`appeal` ADD CONSTRAINT `fk_advancement_appeal_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ADD CONSTRAINT `fk_advancement_major_gift_proposal_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ADD CONSTRAINT `fk_advancement_major_gift_proposal_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ADD CONSTRAINT `fk_advancement_planned_gift_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ADD CONSTRAINT `fk_advancement_prospect_rating_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ADD CONSTRAINT `fk_advancement_stewardship_action_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`endowment` ADD CONSTRAINT `fk_advancement_endowment_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`advancement`.`endowment` ADD CONSTRAINT `fk_advancement_endowment_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`endowment` ADD CONSTRAINT `fk_advancement_endowment_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`advancement`.`event` ADD CONSTRAINT `fk_advancement_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`advancement`.`event` ADD CONSTRAINT `fk_advancement_event_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);

-- ========= advancement --> hr (23 constraint(s)) =========
-- Requires: advancement schema, hr schema
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ADD CONSTRAINT `fk_advancement_alumnus_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ADD CONSTRAINT `fk_advancement_engagement_activity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ADD CONSTRAINT `fk_advancement_alumni_event_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ADD CONSTRAINT `fk_advancement_alumni_event_registration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`donor` ADD CONSTRAINT `fk_advancement_donor_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`gift` ADD CONSTRAINT `fk_advancement_gift_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`gift` ADD CONSTRAINT `fk_advancement_gift_gift_officer_employee_id` FOREIGN KEY (`gift_officer_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`pledge` ADD CONSTRAINT `fk_advancement_pledge_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`campaign` ADD CONSTRAINT `fk_advancement_campaign_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`campaign` ADD CONSTRAINT `fk_advancement_campaign_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ADD CONSTRAINT `fk_advancement_advancement_fund_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ADD CONSTRAINT `fk_advancement_advancement_fund_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`advancement`.`appeal` ADD CONSTRAINT `fk_advancement_appeal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`appeal` ADD CONSTRAINT `fk_advancement_appeal_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ADD CONSTRAINT `fk_advancement_major_gift_proposal_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ADD CONSTRAINT `fk_advancement_major_gift_proposal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ADD CONSTRAINT `fk_advancement_planned_gift_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ADD CONSTRAINT `fk_advancement_planned_gift_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ADD CONSTRAINT `fk_advancement_prospect_rating_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ADD CONSTRAINT `fk_advancement_stewardship_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`endowment` ADD CONSTRAINT `fk_advancement_endowment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`advancement`.`endowment` ADD CONSTRAINT `fk_advancement_endowment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`event` ADD CONSTRAINT `fk_advancement_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);

-- ========= advancement --> research (5 constraint(s)) =========
-- Requires: advancement schema, research schema
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ADD CONSTRAINT `fk_advancement_engagement_activity_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`advancement`.`gift` ADD CONSTRAINT `fk_advancement_gift_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`advancement`.`pledge` ADD CONSTRAINT `fk_advancement_pledge_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ADD CONSTRAINT `fk_advancement_planned_gift_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ADD CONSTRAINT `fk_advancement_stewardship_action_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);

-- ========= advancement --> student (3 constraint(s)) =========
-- Requires: advancement schema, student schema
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ADD CONSTRAINT `fk_advancement_alumnus_degree_conferral_id` FOREIGN KEY (`degree_conferral_id`) REFERENCES `education_ecm`.`student`.`degree_conferral`(`degree_conferral_id`);
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ADD CONSTRAINT `fk_advancement_alumnus_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`advancement`.`constituent` ADD CONSTRAINT `fk_advancement_constituent_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);

-- ========= advancement --> studentlife (3 constraint(s)) =========
-- Requires: advancement schema, studentlife schema
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ADD CONSTRAINT `fk_advancement_engagement_activity_campus_event_id` FOREIGN KEY (`campus_event_id`) REFERENCES `education_ecm`.`studentlife`.`campus_event`(`campus_event_id`);
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ADD CONSTRAINT `fk_advancement_advancement_fund_student_org_id` FOREIGN KEY (`student_org_id`) REFERENCES `education_ecm`.`studentlife`.`student_org`(`student_org_id`);
ALTER TABLE `education_ecm`.`advancement`.`endowment` ADD CONSTRAINT `fk_advancement_endowment_student_org_id` FOREIGN KEY (`student_org_id`) REFERENCES `education_ecm`.`studentlife`.`student_org`(`student_org_id`);

-- ========= aid --> advancement (5 constraint(s)) =========
-- Requires: aid schema, advancement schema
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ADD CONSTRAINT `fk_aid_aid_fund_donor_id` FOREIGN KEY (`donor_id`) REFERENCES `education_ecm`.`advancement`.`donor`(`donor_id`);
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ADD CONSTRAINT `fk_aid_aid_fund_endowment_id` FOREIGN KEY (`endowment_id`) REFERENCES `education_ecm`.`advancement`.`endowment`(`endowment_id`);
ALTER TABLE `education_ecm`.`aid`.`scholarship` ADD CONSTRAINT `fk_aid_scholarship_advancement_fund_id` FOREIGN KEY (`advancement_fund_id`) REFERENCES `education_ecm`.`advancement`.`advancement_fund`(`advancement_fund_id`);
ALTER TABLE `education_ecm`.`aid`.`scholarship` ADD CONSTRAINT `fk_aid_scholarship_donor_id` FOREIGN KEY (`donor_id`) REFERENCES `education_ecm`.`advancement`.`donor`(`donor_id`);
ALTER TABLE `education_ecm`.`aid`.`scholarship` ADD CONSTRAINT `fk_aid_scholarship_endowment_id` FOREIGN KEY (`endowment_id`) REFERENCES `education_ecm`.`advancement`.`endowment`(`endowment_id`);

-- ========= aid --> billing (8 constraint(s)) =========
-- Requires: aid schema, billing schema
ALTER TABLE `education_ecm`.`aid`.`aid_application` ADD CONSTRAINT `fk_aid_aid_application_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`aid`.`award_package` ADD CONSTRAINT `fk_aid_award_package_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`aid`.`aid_award` ADD CONSTRAINT `fk_aid_aid_award_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`aid`.`disbursement` ADD CONSTRAINT `fk_aid_disbursement_statement_id` FOREIGN KEY (`statement_id`) REFERENCES `education_ecm`.`billing`.`statement`(`statement_id`);
ALTER TABLE `education_ecm`.`aid`.`disbursement` ADD CONSTRAINT `fk_aid_disbursement_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ADD CONSTRAINT `fk_aid_coa_budget_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `education_ecm`.`billing`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `education_ecm`.`aid`.`loan_record` ADD CONSTRAINT `fk_aid_loan_record_statement_id` FOREIGN KEY (`statement_id`) REFERENCES `education_ecm`.`billing`.`statement`(`statement_id`);
ALTER TABLE `education_ecm`.`aid`.`loan_record` ADD CONSTRAINT `fk_aid_loan_record_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);

-- ========= aid --> compliance (19 constraint(s)) =========
-- Requires: aid schema, compliance schema
ALTER TABLE `education_ecm`.`aid`.`aid_application` ADD CONSTRAINT `fk_aid_aid_application_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`aid`.`award_package` ADD CONSTRAINT `fk_aid_award_package_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`aid`.`award_package` ADD CONSTRAINT `fk_aid_award_package_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`aid`.`aid_award` ADD CONSTRAINT `fk_aid_aid_award_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`aid`.`disbursement` ADD CONSTRAINT `fk_aid_disbursement_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `education_ecm`.`aid`.`disbursement` ADD CONSTRAINT `fk_aid_disbursement_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ADD CONSTRAINT `fk_aid_aid_fund_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ADD CONSTRAINT `fk_aid_aid_fund_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ADD CONSTRAINT `fk_aid_coa_budget_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`aid`.`isir_record` ADD CONSTRAINT `fk_aid_isir_record_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`aid`.`verification` ADD CONSTRAINT `fk_aid_verification_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ADD CONSTRAINT `fk_aid_sap_evaluation_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ADD CONSTRAINT `fk_aid_sap_evaluation_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`aid`.`loan_record` ADD CONSTRAINT `fk_aid_loan_record_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `education_ecm`.`aid`.`loan_record` ADD CONSTRAINT `fk_aid_loan_record_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`aid`.`scholarship` ADD CONSTRAINT `fk_aid_scholarship_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`aid`.`scholarship` ADD CONSTRAINT `fk_aid_scholarship_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ADD CONSTRAINT `fk_aid_veteran_benefit_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ADD CONSTRAINT `fk_aid_veteran_benefit_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= aid --> curriculum (12 constraint(s)) =========
-- Requires: aid schema, curriculum schema
ALTER TABLE `education_ecm`.`aid`.`aid_application` ADD CONSTRAINT `fk_aid_aid_application_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`aid`.`award_package` ADD CONSTRAINT `fk_aid_award_package_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`aid`.`aid_award` ADD CONSTRAINT `fk_aid_aid_award_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ADD CONSTRAINT `fk_aid_aid_fund_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ADD CONSTRAINT `fk_aid_aid_fund_cip_code_id` FOREIGN KEY (`cip_code_id`) REFERENCES `education_ecm`.`curriculum`.`cip_code`(`cip_code_id`);
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ADD CONSTRAINT `fk_aid_coa_budget_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ADD CONSTRAINT `fk_aid_sap_evaluation_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`aid`.`loan_record` ADD CONSTRAINT `fk_aid_loan_record_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`aid`.`scholarship` ADD CONSTRAINT `fk_aid_scholarship_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`aid`.`scholarship` ADD CONSTRAINT `fk_aid_scholarship_cip_code_id` FOREIGN KEY (`cip_code_id`) REFERENCES `education_ecm`.`curriculum`.`cip_code`(`cip_code_id`);
ALTER TABLE `education_ecm`.`aid`.`scholarship` ADD CONSTRAINT `fk_aid_scholarship_concentration_id` FOREIGN KEY (`concentration_id`) REFERENCES `education_ecm`.`curriculum`.`concentration`(`concentration_id`);
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ADD CONSTRAINT `fk_aid_veteran_benefit_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);

-- ========= aid --> enrollment (4 constraint(s)) =========
-- Requires: aid schema, enrollment schema
ALTER TABLE `education_ecm`.`aid`.`aid_award` ADD CONSTRAINT `fk_aid_aid_award_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`aid`.`disbursement` ADD CONSTRAINT `fk_aid_disbursement_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ADD CONSTRAINT `fk_aid_sap_evaluation_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ADD CONSTRAINT `fk_aid_veteran_benefit_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);

-- ========= aid --> facility (3 constraint(s)) =========
-- Requires: aid schema, facility schema
ALTER TABLE `education_ecm`.`aid`.`aid_application` ADD CONSTRAINT `fk_aid_aid_application_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ADD CONSTRAINT `fk_aid_coa_budget_campus_id` FOREIGN KEY (`campus_id`) REFERENCES `education_ecm`.`facility`.`campus`(`campus_id`);
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ADD CONSTRAINT `fk_aid_veteran_benefit_campus_id` FOREIGN KEY (`campus_id`) REFERENCES `education_ecm`.`facility`.`campus`(`campus_id`);

-- ========= aid --> faculty (3 constraint(s)) =========
-- Requires: aid schema, faculty schema
ALTER TABLE `education_ecm`.`aid`.`aid_application` ADD CONSTRAINT `fk_aid_aid_application_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ADD CONSTRAINT `fk_aid_sap_evaluation_advising_assignment_id` FOREIGN KEY (`advising_assignment_id`) REFERENCES `education_ecm`.`faculty`.`advising_assignment`(`advising_assignment_id`);
ALTER TABLE `education_ecm`.`aid`.`scholarship` ADD CONSTRAINT `fk_aid_scholarship_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);

-- ========= aid --> finance (11 constraint(s)) =========
-- Requires: aid schema, finance schema
ALTER TABLE `education_ecm`.`aid`.`disbursement` ADD CONSTRAINT `fk_aid_disbursement_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `education_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `education_ecm`.`aid`.`disbursement` ADD CONSTRAINT `fk_aid_disbursement_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`aid`.`disbursement` ADD CONSTRAINT `fk_aid_disbursement_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `education_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ADD CONSTRAINT `fk_aid_aid_fund_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ADD CONSTRAINT `fk_aid_aid_fund_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ADD CONSTRAINT `fk_aid_aid_fund_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`aid`.`loan_record` ADD CONSTRAINT `fk_aid_loan_record_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `education_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `education_ecm`.`aid`.`loan_record` ADD CONSTRAINT `fk_aid_loan_record_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`aid`.`scholarship` ADD CONSTRAINT `fk_aid_scholarship_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`aid`.`scholarship` ADD CONSTRAINT `fk_aid_scholarship_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ADD CONSTRAINT `fk_aid_veteran_benefit_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);

-- ========= aid --> hr (10 constraint(s)) =========
-- Requires: aid schema, hr schema
ALTER TABLE `education_ecm`.`aid`.`aid_application` ADD CONSTRAINT `fk_aid_aid_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`aid`.`award_package` ADD CONSTRAINT `fk_aid_award_package_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`aid`.`disbursement` ADD CONSTRAINT `fk_aid_disbursement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ADD CONSTRAINT `fk_aid_coa_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`aid`.`verification` ADD CONSTRAINT `fk_aid_verification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ADD CONSTRAINT `fk_aid_sap_evaluation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`aid`.`loan_record` ADD CONSTRAINT `fk_aid_loan_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`aid`.`scholarship` ADD CONSTRAINT `fk_aid_scholarship_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`aid`.`scholarship` ADD CONSTRAINT `fk_aid_scholarship_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ADD CONSTRAINT `fk_aid_veteran_benefit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);

-- ========= aid --> instruction (3 constraint(s)) =========
-- Requires: aid schema, instruction schema
ALTER TABLE `education_ecm`.`aid`.`aid_award` ADD CONSTRAINT `fk_aid_aid_award_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);
ALTER TABLE `education_ecm`.`aid`.`disbursement` ADD CONSTRAINT `fk_aid_disbursement_attendance_record_id` FOREIGN KEY (`attendance_record_id`) REFERENCES `education_ecm`.`instruction`.`attendance_record`(`attendance_record_id`);
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ADD CONSTRAINT `fk_aid_veteran_benefit_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);

-- ========= aid --> research (2 constraint(s)) =========
-- Requires: aid schema, research schema
ALTER TABLE `education_ecm`.`aid`.`aid_award` ADD CONSTRAINT `fk_aid_aid_award_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ADD CONSTRAINT `fk_aid_aid_fund_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);

-- ========= aid --> student (16 constraint(s)) =========
-- Requires: aid schema, student schema
ALTER TABLE `education_ecm`.`aid`.`aid_application` ADD CONSTRAINT `fk_aid_aid_application_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`aid`.`aid_application` ADD CONSTRAINT `fk_aid_aid_application_residency_classification_id` FOREIGN KEY (`residency_classification_id`) REFERENCES `education_ecm`.`student`.`residency_classification`(`residency_classification_id`);
ALTER TABLE `education_ecm`.`aid`.`aid_application` ADD CONSTRAINT `fk_aid_aid_application_visa_immigration_id` FOREIGN KEY (`visa_immigration_id`) REFERENCES `education_ecm`.`student`.`visa_immigration`(`visa_immigration_id`);
ALTER TABLE `education_ecm`.`aid`.`award_package` ADD CONSTRAINT `fk_aid_award_package_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`aid`.`aid_award` ADD CONSTRAINT `fk_aid_aid_award_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`aid`.`disbursement` ADD CONSTRAINT `fk_aid_disbursement_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `education_ecm`.`student`.`hold`(`hold_id`);
ALTER TABLE `education_ecm`.`aid`.`disbursement` ADD CONSTRAINT `fk_aid_disbursement_leave_of_absence_id` FOREIGN KEY (`leave_of_absence_id`) REFERENCES `education_ecm`.`student`.`leave_of_absence`(`leave_of_absence_id`);
ALTER TABLE `education_ecm`.`aid`.`disbursement` ADD CONSTRAINT `fk_aid_disbursement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`aid`.`isir_record` ADD CONSTRAINT `fk_aid_isir_record_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`aid`.`verification` ADD CONSTRAINT `fk_aid_verification_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ADD CONSTRAINT `fk_aid_sap_evaluation_academic_standing_id` FOREIGN KEY (`academic_standing_id`) REFERENCES `education_ecm`.`student`.`academic_standing`(`academic_standing_id`);
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ADD CONSTRAINT `fk_aid_sap_evaluation_degree_progress_id` FOREIGN KEY (`degree_progress_id`) REFERENCES `education_ecm`.`student`.`degree_progress`(`degree_progress_id`);
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ADD CONSTRAINT `fk_aid_sap_evaluation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`aid`.`loan_record` ADD CONSTRAINT `fk_aid_loan_record_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ADD CONSTRAINT `fk_aid_veteran_benefit_enrollment_status_id` FOREIGN KEY (`enrollment_status_id`) REFERENCES `education_ecm`.`student`.`enrollment_status`(`enrollment_status_id`);
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ADD CONSTRAINT `fk_aid_veteran_benefit_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);

-- ========= aid --> studentlife (3 constraint(s)) =========
-- Requires: aid schema, studentlife schema
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ADD CONSTRAINT `fk_aid_coa_budget_dining_plan_id` FOREIGN KEY (`dining_plan_id`) REFERENCES `education_ecm`.`studentlife`.`dining_plan`(`dining_plan_id`);
ALTER TABLE `education_ecm`.`aid`.`scholarship` ADD CONSTRAINT `fk_aid_scholarship_student_org_id` FOREIGN KEY (`student_org_id`) REFERENCES `education_ecm`.`studentlife`.`student_org`(`student_org_id`);
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ADD CONSTRAINT `fk_aid_veteran_benefit_housing_assignment_id` FOREIGN KEY (`housing_assignment_id`) REFERENCES `education_ecm`.`studentlife`.`housing_assignment`(`housing_assignment_id`);

-- ========= billing --> advancement (3 constraint(s)) =========
-- Requires: billing schema, advancement schema
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ADD CONSTRAINT `fk_billing_tuition_charge_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`billing`.`account_hold` ADD CONSTRAINT `fk_billing_account_hold_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ADD CONSTRAINT `fk_billing_tax_form_1098t_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);

-- ========= billing --> aid (3 constraint(s)) =========
-- Requires: billing schema, aid schema
ALTER TABLE `education_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_disbursement_id` FOREIGN KEY (`disbursement_id`) REFERENCES `education_ecm`.`aid`.`disbursement`(`disbursement_id`);
ALTER TABLE `education_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_aid_award_id` FOREIGN KEY (`aid_award_id`) REFERENCES `education_ecm`.`aid`.`aid_award`(`aid_award_id`);
ALTER TABLE `education_ecm`.`billing`.`account_hold` ADD CONSTRAINT `fk_billing_account_hold_sap_evaluation_id` FOREIGN KEY (`sap_evaluation_id`) REFERENCES `education_ecm`.`aid`.`sap_evaluation`(`sap_evaluation_id`);

-- ========= billing --> compliance (16 constraint(s)) =========
-- Requires: billing schema, compliance schema
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ADD CONSTRAINT `fk_billing_tuition_charge_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ADD CONSTRAINT `fk_billing_tuition_charge_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`billing`.`statement` ADD CONSTRAINT `fk_billing_statement_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ADD CONSTRAINT `fk_billing_third_party_contract_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ADD CONSTRAINT `fk_billing_third_party_contract_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`billing`.`account_hold` ADD CONSTRAINT `fk_billing_account_hold_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`billing`.`account_hold` ADD CONSTRAINT `fk_billing_account_hold_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ADD CONSTRAINT `fk_billing_tax_form_1098t_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ADD CONSTRAINT `fk_billing_tax_form_1098t_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ADD CONSTRAINT `fk_billing_tax_form_1098t_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ADD CONSTRAINT `fk_billing_fee_schedule_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ADD CONSTRAINT `fk_billing_fee_schedule_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= billing --> curriculum (7 constraint(s)) =========
-- Requires: billing schema, curriculum schema
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ADD CONSTRAINT `fk_billing_tuition_charge_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ADD CONSTRAINT `fk_billing_tuition_charge_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ADD CONSTRAINT `fk_billing_tuition_charge_section_id` FOREIGN KEY (`section_id`) REFERENCES `education_ecm`.`curriculum`.`section`(`section_id`);
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ADD CONSTRAINT `fk_billing_third_party_contract_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ADD CONSTRAINT `fk_billing_fee_schedule_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ADD CONSTRAINT `fk_billing_fee_schedule_concentration_id` FOREIGN KEY (`concentration_id`) REFERENCES `education_ecm`.`curriculum`.`concentration`(`concentration_id`);
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ADD CONSTRAINT `fk_billing_fee_schedule_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);

-- ========= billing --> enrollment (5 constraint(s)) =========
-- Requires: billing schema, enrollment schema
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ADD CONSTRAINT `fk_billing_tuition_charge_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`billing`.`statement` ADD CONSTRAINT `fk_billing_statement_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ADD CONSTRAINT `fk_billing_fee_schedule_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);

-- ========= billing --> facility (6 constraint(s)) =========
-- Requires: billing schema, facility schema
ALTER TABLE `education_ecm`.`billing`.`student_account` ADD CONSTRAINT `fk_billing_student_account_campus_id` FOREIGN KEY (`campus_id`) REFERENCES `education_ecm`.`facility`.`campus`(`campus_id`);
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ADD CONSTRAINT `fk_billing_tuition_charge_campus_id` FOREIGN KEY (`campus_id`) REFERENCES `education_ecm`.`facility`.`campus`(`campus_id`);
ALTER TABLE `education_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_room_booking_id` FOREIGN KEY (`room_booking_id`) REFERENCES `education_ecm`.`facility`.`room_booking`(`room_booking_id`);
ALTER TABLE `education_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_room_booking_id` FOREIGN KEY (`room_booking_id`) REFERENCES `education_ecm`.`facility`.`room_booking`(`room_booking_id`);
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ADD CONSTRAINT `fk_billing_third_party_contract_campus_id` FOREIGN KEY (`campus_id`) REFERENCES `education_ecm`.`facility`.`campus`(`campus_id`);
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ADD CONSTRAINT `fk_billing_fee_schedule_campus_id` FOREIGN KEY (`campus_id`) REFERENCES `education_ecm`.`facility`.`campus`(`campus_id`);

-- ========= billing --> finance (18 constraint(s)) =========
-- Requires: billing schema, finance schema
ALTER TABLE `education_ecm`.`billing`.`student_account` ADD CONSTRAINT `fk_billing_student_account_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`billing`.`student_account` ADD CONSTRAINT `fk_billing_student_account_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `education_ecm`.`finance`.`vendor`(`vendor_id`);
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ADD CONSTRAINT `fk_billing_tuition_charge_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ADD CONSTRAINT `fk_billing_tuition_charge_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ADD CONSTRAINT `fk_billing_tuition_charge_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ADD CONSTRAINT `fk_billing_tuition_charge_grant_account_id` FOREIGN KEY (`grant_account_id`) REFERENCES `education_ecm`.`finance`.`grant_account`(`grant_account_id`);
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ADD CONSTRAINT `fk_billing_tuition_charge_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`billing`.`statement` ADD CONSTRAINT `fk_billing_statement_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_ar_receipt_id` FOREIGN KEY (`ar_receipt_id`) REFERENCES `education_ecm`.`finance`.`ar_receipt`(`ar_receipt_id`);
ALTER TABLE `education_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `education_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `education_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `education_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `education_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `education_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `education_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `education_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ADD CONSTRAINT `fk_billing_third_party_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `education_ecm`.`finance`.`vendor`(`vendor_id`);
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ADD CONSTRAINT `fk_billing_tax_form_1098t_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ADD CONSTRAINT `fk_billing_fee_schedule_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ADD CONSTRAINT `fk_billing_fee_schedule_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);

-- ========= billing --> hr (13 constraint(s)) =========
-- Requires: billing schema, hr schema
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ADD CONSTRAINT `fk_billing_tuition_charge_benefit_plan_id` FOREIGN KEY (`benefit_plan_id`) REFERENCES `education_ecm`.`hr`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ADD CONSTRAINT `fk_billing_tuition_charge_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ADD CONSTRAINT `fk_billing_tuition_charge_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_refund_processed_by_user_employee_id` FOREIGN KEY (`refund_processed_by_user_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ADD CONSTRAINT `fk_billing_third_party_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`billing`.`account_hold` ADD CONSTRAINT `fk_billing_account_hold_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`billing`.`account_hold` ADD CONSTRAINT `fk_billing_account_hold_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`billing`.`account_hold` ADD CONSTRAINT `fk_billing_account_hold_tertiary_account_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_account_last_modified_by_user_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ADD CONSTRAINT `fk_billing_fee_schedule_benefit_plan_id` FOREIGN KEY (`benefit_plan_id`) REFERENCES `education_ecm`.`hr`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ADD CONSTRAINT `fk_billing_fee_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ADD CONSTRAINT `fk_billing_fee_schedule_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);

-- ========= billing --> research (2 constraint(s)) =========
-- Requires: billing schema, research schema
ALTER TABLE `education_ecm`.`billing`.`student_account` ADD CONSTRAINT `fk_billing_student_account_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `education_ecm`.`research`.`sponsor`(`sponsor_id`);
ALTER TABLE `education_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);

-- ========= billing --> student (13 constraint(s)) =========
-- Requires: billing schema, student schema
ALTER TABLE `education_ecm`.`billing`.`student_account` ADD CONSTRAINT `fk_billing_student_account_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ADD CONSTRAINT `fk_billing_tuition_charge_enrollment_status_id` FOREIGN KEY (`enrollment_status_id`) REFERENCES `education_ecm`.`student`.`enrollment_status`(`enrollment_status_id`);
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ADD CONSTRAINT `fk_billing_tuition_charge_graduation_application_id` FOREIGN KEY (`graduation_application_id`) REFERENCES `education_ecm`.`student`.`graduation_application`(`graduation_application_id`);
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ADD CONSTRAINT `fk_billing_tuition_charge_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ADD CONSTRAINT `fk_billing_tuition_charge_residency_classification_id` FOREIGN KEY (`residency_classification_id`) REFERENCES `education_ecm`.`student`.`residency_classification`(`residency_classification_id`);
ALTER TABLE `education_ecm`.`billing`.`statement` ADD CONSTRAINT `fk_billing_statement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_graduation_application_id` FOREIGN KEY (`graduation_application_id`) REFERENCES `education_ecm`.`student`.`graduation_application`(`graduation_application_id`);
ALTER TABLE `education_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_leave_of_absence_id` FOREIGN KEY (`leave_of_absence_id`) REFERENCES `education_ecm`.`student`.`leave_of_absence`(`leave_of_absence_id`);
ALTER TABLE `education_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`billing`.`account_hold` ADD CONSTRAINT `fk_billing_account_hold_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ADD CONSTRAINT `fk_billing_tax_form_1098t_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);

-- ========= billing --> studentlife (4 constraint(s)) =========
-- Requires: billing schema, studentlife schema
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ADD CONSTRAINT `fk_billing_tuition_charge_dining_enrollment_id` FOREIGN KEY (`dining_enrollment_id`) REFERENCES `education_ecm`.`studentlife`.`dining_enrollment`(`dining_enrollment_id`);
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ADD CONSTRAINT `fk_billing_tuition_charge_health_visit_id` FOREIGN KEY (`health_visit_id`) REFERENCES `education_ecm`.`studentlife`.`health_visit`(`health_visit_id`);
ALTER TABLE `education_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_housing_assignment_id` FOREIGN KEY (`housing_assignment_id`) REFERENCES `education_ecm`.`studentlife`.`housing_assignment`(`housing_assignment_id`);
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ADD CONSTRAINT `fk_billing_fee_schedule_dining_plan_id` FOREIGN KEY (`dining_plan_id`) REFERENCES `education_ecm`.`studentlife`.`dining_plan`(`dining_plan_id`);

-- ========= compliance --> curriculum (1 constraint(s)) =========
-- Requires: compliance schema, curriculum schema
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ADD CONSTRAINT `fk_compliance_accreditation_review_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);

-- ========= compliance --> facility (4 constraint(s)) =========
-- Requires: compliance schema, facility schema
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ADD CONSTRAINT `fk_compliance_clery_incident_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ADD CONSTRAINT `fk_compliance_accreditation_review_campus_id` FOREIGN KEY (`campus_id`) REFERENCES `education_ecm`.`facility`.`campus`(`campus_id`);
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);

-- ========= compliance --> hr (17 constraint(s)) =========
-- Requires: compliance schema, hr schema
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ADD CONSTRAINT `fk_compliance_regulatory_requirement_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ADD CONSTRAINT `fk_compliance_title_ix_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ADD CONSTRAINT `fk_compliance_title_ix_case_tertiary_title_decision_maker_employee_id` FOREIGN KEY (`tertiary_title_decision_maker_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ADD CONSTRAINT `fk_compliance_clery_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ADD CONSTRAINT `fk_compliance_ferpa_disclosure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ADD CONSTRAINT `fk_compliance_accreditation_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`compliance`.`accreditation_standard` ADD CONSTRAINT `fk_compliance_accreditation_standard_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`compliance`.`accreditation_standard` ADD CONSTRAINT `fk_compliance_accreditation_standard_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`compliance`.`training_program` ADD CONSTRAINT `fk_compliance_training_program_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `education_ecm`.`hr`.`job_profile`(`job_profile_id`);
ALTER TABLE `education_ecm`.`compliance`.`training_program` ADD CONSTRAINT `fk_compliance_training_program_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);

-- ========= compliance --> instruction (3 constraint(s)) =========
-- Requires: compliance schema, instruction schema
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ADD CONSTRAINT `fk_compliance_title_ix_case_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ADD CONSTRAINT `fk_compliance_ferpa_disclosure_attendance_record_id` FOREIGN KEY (`attendance_record_id`) REFERENCES `education_ecm`.`instruction`.`attendance_record`(`attendance_record_id`);
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ADD CONSTRAINT `fk_compliance_ferpa_disclosure_final_grade_id` FOREIGN KEY (`final_grade_id`) REFERENCES `education_ecm`.`instruction`.`final_grade`(`final_grade_id`);

-- ========= compliance --> research (1 constraint(s)) =========
-- Requires: compliance schema, research schema
ALTER TABLE `education_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);

-- ========= compliance --> student (3 constraint(s)) =========
-- Requires: compliance schema, student schema
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ADD CONSTRAINT `fk_compliance_title_ix_case_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ADD CONSTRAINT `fk_compliance_ferpa_disclosure_ferpa_consent_id` FOREIGN KEY (`ferpa_consent_id`) REFERENCES `education_ecm`.`student`.`ferpa_consent`(`ferpa_consent_id`);
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ADD CONSTRAINT `fk_compliance_ferpa_disclosure_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);

-- ========= compliance --> studentlife (9 constraint(s)) =========
-- Requires: compliance schema, studentlife schema
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ADD CONSTRAINT `fk_compliance_title_ix_case_conduct_case_id` FOREIGN KEY (`conduct_case_id`) REFERENCES `education_ecm`.`studentlife`.`conduct_case`(`conduct_case_id`);
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ADD CONSTRAINT `fk_compliance_clery_incident_conduct_case_id` FOREIGN KEY (`conduct_case_id`) REFERENCES `education_ecm`.`studentlife`.`conduct_case`(`conduct_case_id`);
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ADD CONSTRAINT `fk_compliance_clery_incident_housing_assignment_id` FOREIGN KEY (`housing_assignment_id`) REFERENCES `education_ecm`.`studentlife`.`housing_assignment`(`housing_assignment_id`);
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ADD CONSTRAINT `fk_compliance_clery_incident_residence_hall_id` FOREIGN KEY (`residence_hall_id`) REFERENCES `education_ecm`.`studentlife`.`residence_hall`(`residence_hall_id`);
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ADD CONSTRAINT `fk_compliance_ferpa_disclosure_conduct_case_id` FOREIGN KEY (`conduct_case_id`) REFERENCES `education_ecm`.`studentlife`.`conduct_case`(`conduct_case_id`);
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ADD CONSTRAINT `fk_compliance_ferpa_disclosure_counseling_case_id` FOREIGN KEY (`counseling_case_id`) REFERENCES `education_ecm`.`studentlife`.`counseling_case`(`counseling_case_id`);
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ADD CONSTRAINT `fk_compliance_ferpa_disclosure_health_visit_id` FOREIGN KEY (`health_visit_id`) REFERENCES `education_ecm`.`studentlife`.`health_visit`(`health_visit_id`);
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_student_org_id` FOREIGN KEY (`student_org_id`) REFERENCES `education_ecm`.`studentlife`.`student_org`(`student_org_id`);
ALTER TABLE `education_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_residence_hall_id` FOREIGN KEY (`residence_hall_id`) REFERENCES `education_ecm`.`studentlife`.`residence_hall`(`residence_hall_id`);

-- ========= curriculum --> compliance (16 constraint(s)) =========
-- Requires: curriculum schema, compliance schema
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ADD CONSTRAINT `fk_curriculum_academic_program_accrediting_body_id` FOREIGN KEY (`accrediting_body_id`) REFERENCES `education_ecm`.`compliance`.`accrediting_body`(`accrediting_body_id`);
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ADD CONSTRAINT `fk_curriculum_academic_program_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`curriculum`.`course` ADD CONSTRAINT `fk_curriculum_course_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ADD CONSTRAINT `fk_curriculum_degree_requirement_accreditation_standard_id` FOREIGN KEY (`accreditation_standard_id`) REFERENCES `education_ecm`.`compliance`.`accreditation_standard`(`accreditation_standard_id`);
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ADD CONSTRAINT `fk_curriculum_degree_requirement_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`curriculum`.`slo` ADD CONSTRAINT `fk_curriculum_slo_accreditation_standard_id` FOREIGN KEY (`accreditation_standard_id`) REFERENCES `education_ecm`.`compliance`.`accreditation_standard`(`accreditation_standard_id`);
ALTER TABLE `education_ecm`.`curriculum`.`plo` ADD CONSTRAINT `fk_curriculum_plo_accreditation_standard_id` FOREIGN KEY (`accreditation_standard_id`) REFERENCES `education_ecm`.`compliance`.`accreditation_standard`(`accreditation_standard_id`);
ALTER TABLE `education_ecm`.`curriculum`.`map` ADD CONSTRAINT `fk_curriculum_map_accreditation_standard_id` FOREIGN KEY (`accreditation_standard_id`) REFERENCES `education_ecm`.`compliance`.`accreditation_standard`(`accreditation_standard_id`);
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ADD CONSTRAINT `fk_curriculum_articulation_agreement_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ADD CONSTRAINT `fk_curriculum_transfer_equivalency_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ADD CONSTRAINT `fk_curriculum_program_accreditation_accreditation_standard_id` FOREIGN KEY (`accreditation_standard_id`) REFERENCES `education_ecm`.`compliance`.`accreditation_standard`(`accreditation_standard_id`);
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ADD CONSTRAINT `fk_curriculum_program_accreditation_accrediting_body_id` FOREIGN KEY (`accrediting_body_id`) REFERENCES `education_ecm`.`compliance`.`accrediting_body`(`accrediting_body_id`);
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ADD CONSTRAINT `fk_curriculum_program_accreditation_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ADD CONSTRAINT `fk_curriculum_concentration_accrediting_body_id` FOREIGN KEY (`accrediting_body_id`) REFERENCES `education_ecm`.`compliance`.`accrediting_body`(`accrediting_body_id`);
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ADD CONSTRAINT `fk_curriculum_concentration_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`curriculum`.`institution` ADD CONSTRAINT `fk_curriculum_institution_accrediting_body_id` FOREIGN KEY (`accrediting_body_id`) REFERENCES `education_ecm`.`compliance`.`accrediting_body`(`accrediting_body_id`);

-- ========= curriculum --> enrollment (3 constraint(s)) =========
-- Requires: curriculum schema, enrollment schema
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ADD CONSTRAINT `fk_curriculum_prerequisite_rule_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ADD CONSTRAINT `fk_curriculum_transfer_equivalency_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`curriculum`.`section` ADD CONSTRAINT `fk_curriculum_section_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);

-- ========= curriculum --> facility (8 constraint(s)) =========
-- Requires: curriculum schema, facility schema
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ADD CONSTRAINT `fk_curriculum_academic_program_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ADD CONSTRAINT `fk_curriculum_academic_program_campus_id` FOREIGN KEY (`campus_id`) REFERENCES `education_ecm`.`facility`.`campus`(`campus_id`);
ALTER TABLE `education_ecm`.`curriculum`.`course` ADD CONSTRAINT `fk_curriculum_course_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`curriculum`.`course` ADD CONSTRAINT `fk_curriculum_course_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ADD CONSTRAINT `fk_curriculum_articulation_agreement_campus_id` FOREIGN KEY (`campus_id`) REFERENCES `education_ecm`.`facility`.`campus`(`campus_id`);
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ADD CONSTRAINT `fk_curriculum_concentration_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ADD CONSTRAINT `fk_curriculum_concentration_campus_id` FOREIGN KEY (`campus_id`) REFERENCES `education_ecm`.`facility`.`campus`(`campus_id`);
ALTER TABLE `education_ecm`.`curriculum`.`section` ADD CONSTRAINT `fk_curriculum_section_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);

-- ========= curriculum --> faculty (4 constraint(s)) =========
-- Requires: curriculum schema, faculty schema
ALTER TABLE `education_ecm`.`curriculum`.`slo` ADD CONSTRAINT `fk_curriculum_slo_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`curriculum`.`map` ADD CONSTRAINT `fk_curriculum_map_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`curriculum`.`section` ADD CONSTRAINT `fk_curriculum_section_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`curriculum`.`teaching_assignment` ADD CONSTRAINT `fk_curriculum_teaching_assignment_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);

-- ========= curriculum --> finance (10 constraint(s)) =========
-- Requires: curriculum schema, finance schema
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ADD CONSTRAINT `fk_curriculum_academic_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ADD CONSTRAINT `fk_curriculum_academic_program_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ADD CONSTRAINT `fk_curriculum_academic_program_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`curriculum`.`course` ADD CONSTRAINT `fk_curriculum_course_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`curriculum`.`course` ADD CONSTRAINT `fk_curriculum_course_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ADD CONSTRAINT `fk_curriculum_program_accreditation_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ADD CONSTRAINT `fk_curriculum_program_accreditation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ADD CONSTRAINT `fk_curriculum_concentration_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ADD CONSTRAINT `fk_curriculum_concentration_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`curriculum`.`section` ADD CONSTRAINT `fk_curriculum_section_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= curriculum --> hr (20 constraint(s)) =========
-- Requires: curriculum schema, hr schema
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ADD CONSTRAINT `fk_curriculum_academic_program_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ADD CONSTRAINT `fk_curriculum_academic_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`curriculum`.`course` ADD CONSTRAINT `fk_curriculum_course_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`curriculum`.`course` ADD CONSTRAINT `fk_curriculum_course_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`curriculum`.`course` ADD CONSTRAINT `fk_curriculum_course_course_org_unit_id` FOREIGN KEY (`course_org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ADD CONSTRAINT `fk_curriculum_degree_requirement_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ADD CONSTRAINT `fk_curriculum_prerequisite_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ADD CONSTRAINT `fk_curriculum_prerequisite_rule_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`curriculum`.`slo` ADD CONSTRAINT `fk_curriculum_slo_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`curriculum`.`plo` ADD CONSTRAINT `fk_curriculum_plo_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`curriculum`.`map` ADD CONSTRAINT `fk_curriculum_map_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ADD CONSTRAINT `fk_curriculum_articulation_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ADD CONSTRAINT `fk_curriculum_transfer_equivalency_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ADD CONSTRAINT `fk_curriculum_program_accreditation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ADD CONSTRAINT `fk_curriculum_program_accreditation_tertiary_program_updated_by_employee_id` FOREIGN KEY (`tertiary_program_updated_by_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ADD CONSTRAINT `fk_curriculum_concentration_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ADD CONSTRAINT `fk_curriculum_concentration_concentration_org_unit_id` FOREIGN KEY (`concentration_org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ADD CONSTRAINT `fk_curriculum_concentration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`curriculum`.`teaching_assignment` ADD CONSTRAINT `fk_curriculum_teaching_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`curriculum`.`teaching_assignment` ADD CONSTRAINT `fk_curriculum_teaching_assignment_position_id` FOREIGN KEY (`position_id`) REFERENCES `education_ecm`.`hr`.`position`(`position_id`);

-- ========= enrollment --> aid (8 constraint(s)) =========
-- Requires: enrollment schema, aid schema
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ADD CONSTRAINT `fk_enrollment_enrollment_application_aid_application_id` FOREIGN KEY (`aid_application_id`) REFERENCES `education_ecm`.`aid`.`aid_application`(`aid_application_id`);
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ADD CONSTRAINT `fk_enrollment_admission_decision_award_package_id` FOREIGN KEY (`award_package_id`) REFERENCES `education_ecm`.`aid`.`award_package`(`award_package_id`);
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ADD CONSTRAINT `fk_enrollment_deposit_award_package_id` FOREIGN KEY (`award_package_id`) REFERENCES `education_ecm`.`aid`.`award_package`(`award_package_id`);
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ADD CONSTRAINT `fk_enrollment_matriculation_award_package_id` FOREIGN KEY (`award_package_id`) REFERENCES `education_ecm`.`aid`.`award_package`(`award_package_id`);
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ADD CONSTRAINT `fk_enrollment_admission_offer_award_package_id` FOREIGN KEY (`award_package_id`) REFERENCES `education_ecm`.`aid`.`award_package`(`award_package_id`);
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ADD CONSTRAINT `fk_enrollment_transfer_credit_eval_sap_evaluation_id` FOREIGN KEY (`sap_evaluation_id`) REFERENCES `education_ecm`.`aid`.`sap_evaluation`(`sap_evaluation_id`);
ALTER TABLE `education_ecm`.`enrollment`.`term` ADD CONSTRAINT `fk_enrollment_term_award_year_id` FOREIGN KEY (`award_year_id`) REFERENCES `education_ecm`.`aid`.`award_year`(`award_year_id`);
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ADD CONSTRAINT `fk_enrollment_add_drop_transaction_disbursement_id` FOREIGN KEY (`disbursement_id`) REFERENCES `education_ecm`.`aid`.`disbursement`(`disbursement_id`);

-- ========= enrollment --> billing (11 constraint(s)) =========
-- Requires: enrollment schema, billing schema
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ADD CONSTRAINT `fk_enrollment_enrollment_application_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `education_ecm`.`billing`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ADD CONSTRAINT `fk_enrollment_enrollment_application_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ADD CONSTRAINT `fk_enrollment_deposit_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `education_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ADD CONSTRAINT `fk_enrollment_deposit_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ADD CONSTRAINT `fk_enrollment_matriculation_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`enrollment`.`registration` ADD CONSTRAINT `fk_enrollment_registration_tuition_charge_id` FOREIGN KEY (`tuition_charge_id`) REFERENCES `education_ecm`.`billing`.`tuition_charge`(`tuition_charge_id`);
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ADD CONSTRAINT `fk_enrollment_add_drop_transaction_refund_id` FOREIGN KEY (`refund_id`) REFERENCES `education_ecm`.`billing`.`refund`(`refund_id`);
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ADD CONSTRAINT `fk_enrollment_add_drop_transaction_tuition_charge_id` FOREIGN KEY (`tuition_charge_id`) REFERENCES `education_ecm`.`billing`.`tuition_charge`(`tuition_charge_id`);
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ADD CONSTRAINT `fk_enrollment_student_term_record_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ADD CONSTRAINT `fk_enrollment_registration_hold_account_hold_id` FOREIGN KEY (`account_hold_id`) REFERENCES `education_ecm`.`billing`.`account_hold`(`account_hold_id`);
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ADD CONSTRAINT `fk_enrollment_registration_hold_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);

-- ========= enrollment --> compliance (4 constraint(s)) =========
-- Requires: enrollment schema, compliance schema
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ADD CONSTRAINT `fk_enrollment_admission_criteria_accreditation_standard_id` FOREIGN KEY (`accreditation_standard_id`) REFERENCES `education_ecm`.`compliance`.`accreditation_standard`(`accreditation_standard_id`);
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ADD CONSTRAINT `fk_enrollment_admission_criteria_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ADD CONSTRAINT `fk_enrollment_registration_hold_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `education_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ADD CONSTRAINT `fk_enrollment_registration_hold_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= enrollment --> curriculum (19 constraint(s)) =========
-- Requires: enrollment schema, curriculum schema
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ADD CONSTRAINT `fk_enrollment_prospect_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ADD CONSTRAINT `fk_enrollment_enrollment_application_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ADD CONSTRAINT `fk_enrollment_enrollment_applicant_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ADD CONSTRAINT `fk_enrollment_application_program_concentration_id` FOREIGN KEY (`concentration_id`) REFERENCES `education_ecm`.`curriculum`.`concentration`(`concentration_id`);
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ADD CONSTRAINT `fk_enrollment_application_program_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ADD CONSTRAINT `fk_enrollment_admission_decision_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ADD CONSTRAINT `fk_enrollment_admission_criteria_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ADD CONSTRAINT `fk_enrollment_recruitment_event_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ADD CONSTRAINT `fk_enrollment_event_registration_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ADD CONSTRAINT `fk_enrollment_deposit_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ADD CONSTRAINT `fk_enrollment_matriculation_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ADD CONSTRAINT `fk_enrollment_waitlist_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ADD CONSTRAINT `fk_enrollment_admission_offer_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ADD CONSTRAINT `fk_enrollment_transfer_credit_eval_articulation_agreement_id` FOREIGN KEY (`articulation_agreement_id`) REFERENCES `education_ecm`.`curriculum`.`articulation_agreement`(`articulation_agreement_id`);
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ADD CONSTRAINT `fk_enrollment_transfer_credit_eval_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`enrollment`.`registration` ADD CONSTRAINT `fk_enrollment_registration_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ADD CONSTRAINT `fk_enrollment_add_drop_transaction_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ADD CONSTRAINT `fk_enrollment_student_term_record_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ADD CONSTRAINT `fk_enrollment_student_term_record_concentration_id` FOREIGN KEY (`concentration_id`) REFERENCES `education_ecm`.`curriculum`.`concentration`(`concentration_id`);

-- ========= enrollment --> facility (8 constraint(s)) =========
-- Requires: enrollment schema, facility schema
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ADD CONSTRAINT `fk_enrollment_enrollment_application_campus_id` FOREIGN KEY (`campus_id`) REFERENCES `education_ecm`.`facility`.`campus`(`campus_id`);
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ADD CONSTRAINT `fk_enrollment_admission_criteria_campus_id` FOREIGN KEY (`campus_id`) REFERENCES `education_ecm`.`facility`.`campus`(`campus_id`);
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ADD CONSTRAINT `fk_enrollment_recruitment_event_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ADD CONSTRAINT `fk_enrollment_recruitment_event_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ADD CONSTRAINT `fk_enrollment_matriculation_campus_id` FOREIGN KEY (`campus_id`) REFERENCES `education_ecm`.`facility`.`campus`(`campus_id`);
ALTER TABLE `education_ecm`.`enrollment`.`term` ADD CONSTRAINT `fk_enrollment_term_campus_id` FOREIGN KEY (`campus_id`) REFERENCES `education_ecm`.`facility`.`campus`(`campus_id`);
ALTER TABLE `education_ecm`.`enrollment`.`registration` ADD CONSTRAINT `fk_enrollment_registration_campus_id` FOREIGN KEY (`campus_id`) REFERENCES `education_ecm`.`facility`.`campus`(`campus_id`);
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ADD CONSTRAINT `fk_enrollment_student_term_record_campus_id` FOREIGN KEY (`campus_id`) REFERENCES `education_ecm`.`facility`.`campus`(`campus_id`);

-- ========= enrollment --> faculty (4 constraint(s)) =========
-- Requires: enrollment schema, faculty schema
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ADD CONSTRAINT `fk_enrollment_enrollment_application_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ADD CONSTRAINT `fk_enrollment_application_program_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ADD CONSTRAINT `fk_enrollment_matriculation_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ADD CONSTRAINT `fk_enrollment_student_term_record_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);

-- ========= enrollment --> finance (6 constraint(s)) =========
-- Requires: enrollment schema, finance schema
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ADD CONSTRAINT `fk_enrollment_recruitment_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ADD CONSTRAINT `fk_enrollment_deposit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ADD CONSTRAINT `fk_enrollment_deposit_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ADD CONSTRAINT `fk_enrollment_matriculation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`enrollment`.`term` ADD CONSTRAINT `fk_enrollment_term_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`enrollment`.`registration` ADD CONSTRAINT `fk_enrollment_registration_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= enrollment --> hr (27 constraint(s)) =========
-- Requires: enrollment schema, hr schema
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ADD CONSTRAINT `fk_enrollment_prospect_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ADD CONSTRAINT `fk_enrollment_prospect_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ADD CONSTRAINT `fk_enrollment_enrollment_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ADD CONSTRAINT `fk_enrollment_enrollment_application_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ADD CONSTRAINT `fk_enrollment_enrollment_applicant_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ADD CONSTRAINT `fk_enrollment_application_program_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ADD CONSTRAINT `fk_enrollment_admission_decision_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ADD CONSTRAINT `fk_enrollment_transcript_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ADD CONSTRAINT `fk_enrollment_admission_criteria_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ADD CONSTRAINT `fk_enrollment_admission_criteria_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ADD CONSTRAINT `fk_enrollment_recruitment_event_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ADD CONSTRAINT `fk_enrollment_recruitment_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ADD CONSTRAINT `fk_enrollment_event_registration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ADD CONSTRAINT `fk_enrollment_deposit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ADD CONSTRAINT `fk_enrollment_matriculation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ADD CONSTRAINT `fk_enrollment_waitlist_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ADD CONSTRAINT `fk_enrollment_waitlist_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ADD CONSTRAINT `fk_enrollment_waitlist_waitlist_org_unit_id` FOREIGN KEY (`waitlist_org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ADD CONSTRAINT `fk_enrollment_admission_offer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ADD CONSTRAINT `fk_enrollment_transfer_credit_eval_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ADD CONSTRAINT `fk_enrollment_transfer_credit_eval_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`enrollment`.`registration` ADD CONSTRAINT `fk_enrollment_registration_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`enrollment`.`registration` ADD CONSTRAINT `fk_enrollment_registration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ADD CONSTRAINT `fk_enrollment_add_drop_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ADD CONSTRAINT `fk_enrollment_student_term_record_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ADD CONSTRAINT `fk_enrollment_registration_hold_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ADD CONSTRAINT `fk_enrollment_registration_hold_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);

-- ========= enrollment --> instruction (2 constraint(s)) =========
-- Requires: enrollment schema, instruction schema
ALTER TABLE `education_ecm`.`enrollment`.`registration` ADD CONSTRAINT `fk_enrollment_registration_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ADD CONSTRAINT `fk_enrollment_add_drop_transaction_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);

-- ========= enrollment --> research (7 constraint(s)) =========
-- Requires: enrollment schema, research schema
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ADD CONSTRAINT `fk_enrollment_enrollment_application_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ADD CONSTRAINT `fk_enrollment_enrollment_application_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ADD CONSTRAINT `fk_enrollment_application_program_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ADD CONSTRAINT `fk_enrollment_matriculation_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ADD CONSTRAINT `fk_enrollment_admission_offer_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`enrollment`.`registration` ADD CONSTRAINT `fk_enrollment_registration_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ADD CONSTRAINT `fk_enrollment_student_term_record_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);

-- ========= enrollment --> student (7 constraint(s)) =========
-- Requires: enrollment schema, student schema
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ADD CONSTRAINT `fk_enrollment_deposit_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ADD CONSTRAINT `fk_enrollment_matriculation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ADD CONSTRAINT `fk_enrollment_transfer_credit_eval_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`enrollment`.`registration` ADD CONSTRAINT `fk_enrollment_registration_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ADD CONSTRAINT `fk_enrollment_add_drop_transaction_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ADD CONSTRAINT `fk_enrollment_student_term_record_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ADD CONSTRAINT `fk_enrollment_registration_hold_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);

-- ========= facility --> advancement (3 constraint(s)) =========
-- Requires: facility schema, advancement schema
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ADD CONSTRAINT `fk_facility_space_assignment_advancement_fund_id` FOREIGN KEY (`advancement_fund_id`) REFERENCES `education_ecm`.`advancement`.`advancement_fund`(`advancement_fund_id`);
ALTER TABLE `education_ecm`.`facility`.`room_booking` ADD CONSTRAINT `fk_facility_room_booking_event_id` FOREIGN KEY (`event_id`) REFERENCES `education_ecm`.`advancement`.`event`(`event_id`);
ALTER TABLE `education_ecm`.`facility`.`capital_project` ADD CONSTRAINT `fk_facility_capital_project_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `education_ecm`.`advancement`.`campaign`(`campaign_id`);

-- ========= facility --> compliance (7 constraint(s)) =========
-- Requires: facility schema, compliance schema
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ADD CONSTRAINT `fk_facility_space_assignment_accreditation_review_id` FOREIGN KEY (`accreditation_review_id`) REFERENCES `education_ecm`.`compliance`.`accreditation_review`(`accreditation_review_id`);
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ADD CONSTRAINT `fk_facility_space_assignment_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`facility`.`work_order` ADD CONSTRAINT `fk_facility_work_order_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `education_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `education_ecm`.`facility`.`work_order` ADD CONSTRAINT `fk_facility_work_order_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ADD CONSTRAINT `fk_facility_pm_schedule_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`facility`.`asset` ADD CONSTRAINT `fk_facility_asset_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`facility`.`capital_project` ADD CONSTRAINT `fk_facility_capital_project_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= facility --> curriculum (5 constraint(s)) =========
-- Requires: facility schema, curriculum schema
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ADD CONSTRAINT `fk_facility_space_assignment_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ADD CONSTRAINT `fk_facility_space_assignment_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`facility`.`room_booking` ADD CONSTRAINT `fk_facility_room_booking_section_id` FOREIGN KEY (`section_id`) REFERENCES `education_ecm`.`curriculum`.`section`(`section_id`);
ALTER TABLE `education_ecm`.`facility`.`asset` ADD CONSTRAINT `fk_facility_asset_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`facility`.`capital_project` ADD CONSTRAINT `fk_facility_capital_project_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);

-- ========= facility --> enrollment (1 constraint(s)) =========
-- Requires: facility schema, enrollment schema
ALTER TABLE `education_ecm`.`facility`.`room_booking` ADD CONSTRAINT `fk_facility_room_booking_recruitment_event_id` FOREIGN KEY (`recruitment_event_id`) REFERENCES `education_ecm`.`enrollment`.`recruitment_event`(`recruitment_event_id`);

-- ========= facility --> finance (10 constraint(s)) =========
-- Requires: facility schema, finance schema
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ADD CONSTRAINT `fk_facility_space_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ADD CONSTRAINT `fk_facility_space_assignment_grant_account_id` FOREIGN KEY (`grant_account_id`) REFERENCES `education_ecm`.`finance`.`grant_account`(`grant_account_id`);
ALTER TABLE `education_ecm`.`facility`.`room_booking` ADD CONSTRAINT `fk_facility_room_booking_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`facility`.`work_order` ADD CONSTRAINT `fk_facility_work_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`facility`.`work_order` ADD CONSTRAINT `fk_facility_work_order_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`facility`.`work_order` ADD CONSTRAINT `fk_facility_work_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `education_ecm`.`finance`.`vendor`(`vendor_id`);
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ADD CONSTRAINT `fk_facility_pm_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`facility`.`capital_project` ADD CONSTRAINT `fk_facility_capital_project_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`facility`.`capital_project` ADD CONSTRAINT `fk_facility_capital_project_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`facility`.`capital_project` ADD CONSTRAINT `fk_facility_capital_project_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);

-- ========= facility --> hr (16 constraint(s)) =========
-- Requires: facility schema, hr schema
ALTER TABLE `education_ecm`.`facility`.`building` ADD CONSTRAINT `fk_facility_building_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`facility`.`room` ADD CONSTRAINT `fk_facility_room_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ADD CONSTRAINT `fk_facility_space_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ADD CONSTRAINT `fk_facility_space_assignment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`facility`.`room_booking` ADD CONSTRAINT `fk_facility_room_booking_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`facility`.`room_booking` ADD CONSTRAINT `fk_facility_room_booking_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`facility`.`room_booking` ADD CONSTRAINT `fk_facility_room_booking_primary_room_employee_id` FOREIGN KEY (`primary_room_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`facility`.`work_order` ADD CONSTRAINT `fk_facility_work_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`facility`.`work_order` ADD CONSTRAINT `fk_facility_work_order_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ADD CONSTRAINT `fk_facility_pm_schedule_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ADD CONSTRAINT `fk_facility_pm_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`facility`.`asset` ADD CONSTRAINT `fk_facility_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`facility`.`asset` ADD CONSTRAINT `fk_facility_asset_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`facility`.`capital_project` ADD CONSTRAINT `fk_facility_capital_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`facility`.`capital_project` ADD CONSTRAINT `fk_facility_capital_project_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`facility`.`floor` ADD CONSTRAINT `fk_facility_floor_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);

-- ========= facility --> research (5 constraint(s)) =========
-- Requires: facility schema, research schema
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ADD CONSTRAINT `fk_facility_space_assignment_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`facility`.`work_order` ADD CONSTRAINT `fk_facility_work_order_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ADD CONSTRAINT `fk_facility_pm_schedule_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`facility`.`asset` ADD CONSTRAINT `fk_facility_asset_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`facility`.`capital_project` ADD CONSTRAINT `fk_facility_capital_project_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);

-- ========= facility --> student (1 constraint(s)) =========
-- Requires: facility schema, student schema
ALTER TABLE `education_ecm`.`facility`.`room_booking` ADD CONSTRAINT `fk_facility_room_booking_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);

-- ========= faculty --> advancement (2 constraint(s)) =========
-- Requires: faculty schema, advancement schema
ALTER TABLE `education_ecm`.`faculty`.`appointment` ADD CONSTRAINT `fk_faculty_appointment_advancement_fund_id` FOREIGN KEY (`advancement_fund_id`) REFERENCES `education_ecm`.`advancement`.`advancement_fund`(`advancement_fund_id`);
ALTER TABLE `education_ecm`.`faculty`.`compensation` ADD CONSTRAINT `fk_faculty_compensation_advancement_fund_id` FOREIGN KEY (`advancement_fund_id`) REFERENCES `education_ecm`.`advancement`.`advancement_fund`(`advancement_fund_id`);

-- ========= faculty --> compliance (14 constraint(s)) =========
-- Requires: faculty schema, compliance schema
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ADD CONSTRAINT `fk_faculty_tenure_case_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ADD CONSTRAINT `fk_faculty_rank_history_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`faculty`.`credential` ADD CONSTRAINT `fk_faculty_credential_accreditation_standard_id` FOREIGN KEY (`accreditation_standard_id`) REFERENCES `education_ecm`.`compliance`.`accreditation_standard`(`accreditation_standard_id`);
ALTER TABLE `education_ecm`.`faculty`.`credential` ADD CONSTRAINT `fk_faculty_credential_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ADD CONSTRAINT `fk_faculty_teaching_load_accreditation_standard_id` FOREIGN KEY (`accreditation_standard_id`) REFERENCES `education_ecm`.`compliance`.`accreditation_standard`(`accreditation_standard_id`);
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ADD CONSTRAINT `fk_faculty_annual_review_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ADD CONSTRAINT `fk_faculty_accreditation_qualification_accreditation_review_id` FOREIGN KEY (`accreditation_review_id`) REFERENCES `education_ecm`.`compliance`.`accreditation_review`(`accreditation_review_id`);
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ADD CONSTRAINT `fk_faculty_accreditation_qualification_accreditation_standard_id` FOREIGN KEY (`accreditation_standard_id`) REFERENCES `education_ecm`.`compliance`.`accreditation_standard`(`accreditation_standard_id`);
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ADD CONSTRAINT `fk_faculty_hire_event_accreditation_standard_id` FOREIGN KEY (`accreditation_standard_id`) REFERENCES `education_ecm`.`compliance`.`accreditation_standard`(`accreditation_standard_id`);
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ADD CONSTRAINT `fk_faculty_hire_event_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ADD CONSTRAINT `fk_faculty_hire_event_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`faculty`.`compensation` ADD CONSTRAINT `fk_faculty_compensation_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ADD CONSTRAINT `fk_faculty_leave_record_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ADD CONSTRAINT `fk_faculty_leave_record_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= faculty --> curriculum (4 constraint(s)) =========
-- Requires: faculty schema, curriculum schema
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ADD CONSTRAINT `fk_faculty_accreditation_qualification_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ADD CONSTRAINT `fk_faculty_accreditation_qualification_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ADD CONSTRAINT `fk_faculty_hire_event_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ADD CONSTRAINT `fk_faculty_advising_assignment_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);

-- ========= faculty --> enrollment (4 constraint(s)) =========
-- Requires: faculty schema, enrollment schema
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ADD CONSTRAINT `fk_faculty_teaching_load_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ADD CONSTRAINT `fk_faculty_hire_event_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`faculty`.`compensation` ADD CONSTRAINT `fk_faculty_compensation_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ADD CONSTRAINT `fk_faculty_advising_assignment_student_term_record_id` FOREIGN KEY (`student_term_record_id`) REFERENCES `education_ecm`.`enrollment`.`student_term_record`(`student_term_record_id`);

-- ========= faculty --> facility (2 constraint(s)) =========
-- Requires: faculty schema, facility schema
ALTER TABLE `education_ecm`.`faculty`.`instructor` ADD CONSTRAINT `fk_faculty_instructor_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ADD CONSTRAINT `fk_faculty_department_affiliation_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);

-- ========= faculty --> finance (12 constraint(s)) =========
-- Requires: faculty schema, finance schema
ALTER TABLE `education_ecm`.`faculty`.`appointment` ADD CONSTRAINT `fk_faculty_appointment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`faculty`.`appointment` ADD CONSTRAINT `fk_faculty_appointment_grant_account_id` FOREIGN KEY (`grant_account_id`) REFERENCES `education_ecm`.`finance`.`grant_account`(`grant_account_id`);
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ADD CONSTRAINT `fk_faculty_department_affiliation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ADD CONSTRAINT `fk_faculty_teaching_load_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ADD CONSTRAINT `fk_faculty_annual_review_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ADD CONSTRAINT `fk_faculty_hire_event_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ADD CONSTRAINT `fk_faculty_hire_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`faculty`.`compensation` ADD CONSTRAINT `fk_faculty_compensation_grant_account_id` FOREIGN KEY (`grant_account_id`) REFERENCES `education_ecm`.`finance`.`grant_account`(`grant_account_id`);
ALTER TABLE `education_ecm`.`faculty`.`compensation` ADD CONSTRAINT `fk_faculty_compensation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`faculty`.`compensation` ADD CONSTRAINT `fk_faculty_compensation_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ADD CONSTRAINT `fk_faculty_leave_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ADD CONSTRAINT `fk_faculty_advising_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= faculty --> hr (19 constraint(s)) =========
-- Requires: faculty schema, hr schema
ALTER TABLE `education_ecm`.`faculty`.`instructor` ADD CONSTRAINT `fk_faculty_instructor_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`faculty`.`appointment` ADD CONSTRAINT `fk_faculty_appointment_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `education_ecm`.`hr`.`job_profile`(`job_profile_id`);
ALTER TABLE `education_ecm`.`faculty`.`appointment` ADD CONSTRAINT `fk_faculty_appointment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`faculty`.`appointment` ADD CONSTRAINT `fk_faculty_appointment_position_id` FOREIGN KEY (`position_id`) REFERENCES `education_ecm`.`hr`.`position`(`position_id`);
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ADD CONSTRAINT `fk_faculty_tenure_case_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ADD CONSTRAINT `fk_faculty_rank_history_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ADD CONSTRAINT `fk_faculty_department_affiliation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ADD CONSTRAINT `fk_faculty_teaching_load_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ADD CONSTRAINT `fk_faculty_annual_review_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ADD CONSTRAINT `fk_faculty_accreditation_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ADD CONSTRAINT `fk_faculty_hire_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ADD CONSTRAINT `fk_faculty_hire_event_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `education_ecm`.`hr`.`job_profile`(`job_profile_id`);
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ADD CONSTRAINT `fk_faculty_hire_event_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ADD CONSTRAINT `fk_faculty_hire_event_recruitment_requisition_id` FOREIGN KEY (`recruitment_requisition_id`) REFERENCES `education_ecm`.`hr`.`recruitment_requisition`(`recruitment_requisition_id`);
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ADD CONSTRAINT `fk_faculty_hire_event_staffing_event_id` FOREIGN KEY (`staffing_event_id`) REFERENCES `education_ecm`.`hr`.`staffing_event`(`staffing_event_id`);
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ADD CONSTRAINT `fk_faculty_leave_record_absence_event_id` FOREIGN KEY (`absence_event_id`) REFERENCES `education_ecm`.`hr`.`absence_event`(`absence_event_id`);
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ADD CONSTRAINT `fk_faculty_leave_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ADD CONSTRAINT `fk_faculty_leave_record_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ADD CONSTRAINT `fk_faculty_advising_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);

-- ========= faculty --> instruction (3 constraint(s)) =========
-- Requires: faculty schema, instruction schema
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ADD CONSTRAINT `fk_faculty_teaching_load_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ADD CONSTRAINT `fk_faculty_teaching_load_faculty_assignment_id` FOREIGN KEY (`faculty_assignment_id`) REFERENCES `education_ecm`.`instruction`.`faculty_assignment`(`faculty_assignment_id`);
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ADD CONSTRAINT `fk_faculty_accreditation_qualification_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);

-- ========= faculty --> research (4 constraint(s)) =========
-- Requires: faculty schema, research schema
ALTER TABLE `education_ecm`.`faculty`.`instructor` ADD CONSTRAINT `fk_faculty_instructor_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ADD CONSTRAINT `fk_faculty_teaching_load_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ADD CONSTRAINT `fk_faculty_annual_review_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`faculty`.`compensation` ADD CONSTRAINT `fk_faculty_compensation_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);

-- ========= faculty --> student (2 constraint(s)) =========
-- Requires: faculty schema, student schema
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ADD CONSTRAINT `fk_faculty_advising_assignment_degree_progress_id` FOREIGN KEY (`degree_progress_id`) REFERENCES `education_ecm`.`student`.`degree_progress`(`degree_progress_id`);
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ADD CONSTRAINT `fk_faculty_advising_assignment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);

-- ========= finance --> advancement (2 constraint(s)) =========
-- Requires: finance schema, advancement schema
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_event_id` FOREIGN KEY (`event_id`) REFERENCES `education_ecm`.`advancement`.`event`(`event_id`);
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_donor_id` FOREIGN KEY (`donor_id`) REFERENCES `education_ecm`.`advancement`.`donor`(`donor_id`);

-- ========= finance --> compliance (14 constraint(s)) =========
-- Requires: finance schema, compliance schema
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ADD CONSTRAINT `fk_finance_ledger_account_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ADD CONSTRAINT `fk_finance_finance_fund_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ADD CONSTRAINT `fk_finance_finance_fund_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`finance`.`vendor` ADD CONSTRAINT `fk_finance_vendor_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`finance`.`grant_account` ADD CONSTRAINT `fk_finance_grant_account_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `education_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `education_ecm`.`finance`.`grant_account` ADD CONSTRAINT `fk_finance_grant_account_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= finance --> curriculum (2 constraint(s)) =========
-- Requires: finance schema, curriculum schema
ALTER TABLE `education_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`finance`.`grant_account` ADD CONSTRAINT `fk_finance_grant_account_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);

-- ========= finance --> facility (11 constraint(s)) =========
-- Requires: finance schema, facility schema
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `education_ecm`.`facility`.`capital_project`(`capital_project_id`);
ALTER TABLE `education_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `education_ecm`.`facility`.`capital_project`(`capital_project_id`);
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `education_ecm`.`facility`.`capital_project`(`capital_project_id`);
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ADD CONSTRAINT `fk_finance_purchase_order_line_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `education_ecm`.`facility`.`capital_project`(`capital_project_id`);
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `education_ecm`.`facility`.`capital_project`(`capital_project_id`);
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `education_ecm`.`facility`.`work_order`(`work_order_id`);
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_room_booking_id` FOREIGN KEY (`room_booking_id`) REFERENCES `education_ecm`.`facility`.`room_booking`(`room_booking_id`);
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `education_ecm`.`facility`.`asset`(`asset_id`);
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `education_ecm`.`facility`.`capital_project`(`capital_project_id`);

-- ========= finance --> hr (15 constraint(s)) =========
-- Requires: finance schema, hr schema
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ADD CONSTRAINT `fk_finance_ledger_account_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ADD CONSTRAINT `fk_finance_finance_fund_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_primary_journal_employee_id` FOREIGN KEY (`primary_journal_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`finance`.`journal_line` ADD CONSTRAINT `fk_finance_journal_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`finance`.`journal_line` ADD CONSTRAINT `fk_finance_journal_line_tertiary_journal_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_journal_last_modified_by_user_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ADD CONSTRAINT `fk_finance_purchase_order_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ADD CONSTRAINT `fk_finance_purchase_order_line_requester_employee_id` FOREIGN KEY (`requester_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_primary_ar_employee_id` FOREIGN KEY (`primary_ar_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`finance`.`grant_account` ADD CONSTRAINT `fk_finance_grant_account_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);

-- ========= finance --> research (9 constraint(s)) =========
-- Requires: finance schema, research schema
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `education_ecm`.`research`.`sponsor`(`sponsor_id`);
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `education_ecm`.`research`.`sponsor`(`sponsor_id`);
ALTER TABLE `education_ecm`.`finance`.`grant_account` ADD CONSTRAINT `fk_finance_grant_account_award_budget_id` FOREIGN KEY (`award_budget_id`) REFERENCES `education_ecm`.`research`.`award_budget`(`award_budget_id`);
ALTER TABLE `education_ecm`.`finance`.`grant_account` ADD CONSTRAINT `fk_finance_grant_account_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`finance`.`grant_account` ADD CONSTRAINT `fk_finance_grant_account_proposal_id` FOREIGN KEY (`proposal_id`) REFERENCES `education_ecm`.`research`.`proposal`(`proposal_id`);
ALTER TABLE `education_ecm`.`finance`.`grant_account` ADD CONSTRAINT `fk_finance_grant_account_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);

-- ========= hr --> curriculum (2 constraint(s)) =========
-- Requires: hr schema, curriculum schema
ALTER TABLE `education_ecm`.`hr`.`job_profile` ADD CONSTRAINT `fk_hr_job_profile_cip_code_id` FOREIGN KEY (`cip_code_id`) REFERENCES `education_ecm`.`curriculum`.`cip_code`(`cip_code_id`);
ALTER TABLE `education_ecm`.`hr`.`org_unit` ADD CONSTRAINT `fk_hr_org_unit_cip_code_id` FOREIGN KEY (`cip_code_id`) REFERENCES `education_ecm`.`curriculum`.`cip_code`(`cip_code_id`);

-- ========= hr --> facility (3 constraint(s)) =========
-- Requires: hr schema, facility schema
ALTER TABLE `education_ecm`.`hr`.`position` ADD CONSTRAINT `fk_hr_position_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`hr`.`org_unit` ADD CONSTRAINT `fk_hr_org_unit_campus_id` FOREIGN KEY (`campus_id`) REFERENCES `education_ecm`.`facility`.`campus`(`campus_id`);
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ADD CONSTRAINT `fk_hr_recruitment_requisition_campus_id` FOREIGN KEY (`campus_id`) REFERENCES `education_ecm`.`facility`.`campus`(`campus_id`);

-- ========= hr --> finance (13 constraint(s)) =========
-- Requires: hr schema, finance schema
ALTER TABLE `education_ecm`.`hr`.`org_unit` ADD CONSTRAINT `fk_hr_org_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ADD CONSTRAINT `fk_hr_employee_compensation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ADD CONSTRAINT `fk_hr_employee_compensation_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ADD CONSTRAINT `fk_hr_benefit_plan_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ADD CONSTRAINT `fk_hr_payroll_result_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ADD CONSTRAINT `fk_hr_payroll_result_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ADD CONSTRAINT `fk_hr_payroll_result_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ADD CONSTRAINT `fk_hr_payroll_result_grant_account_id` FOREIGN KEY (`grant_account_id`) REFERENCES `education_ecm`.`finance`.`grant_account`(`grant_account_id`);
ALTER TABLE `education_ecm`.`hr`.`absence_event` ADD CONSTRAINT `fk_hr_absence_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ADD CONSTRAINT `fk_hr_recruitment_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`hr`.`time_entry` ADD CONSTRAINT `fk_hr_time_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`hr`.`time_entry` ADD CONSTRAINT `fk_hr_time_entry_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`hr`.`time_entry` ADD CONSTRAINT `fk_hr_time_entry_grant_account_id` FOREIGN KEY (`grant_account_id`) REFERENCES `education_ecm`.`finance`.`grant_account`(`grant_account_id`);

-- ========= instruction --> billing (2 constraint(s)) =========
-- Requires: instruction schema, billing schema
ALTER TABLE `education_ecm`.`instruction`.`course_section` ADD CONSTRAINT `fk_instruction_course_section_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `education_ecm`.`billing`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ADD CONSTRAINT `fk_instruction_attendance_record_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);

-- ========= instruction --> compliance (4 constraint(s)) =========
-- Requires: instruction schema, compliance schema
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ADD CONSTRAINT `fk_instruction_faculty_assignment_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ADD CONSTRAINT `fk_instruction_attendance_record_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ADD CONSTRAINT `fk_instruction_slo_assessment_accreditation_review_id` FOREIGN KEY (`accreditation_review_id`) REFERENCES `education_ecm`.`compliance`.`accreditation_review`(`accreditation_review_id`);
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ADD CONSTRAINT `fk_instruction_slo_assessment_accreditation_standard_id` FOREIGN KEY (`accreditation_standard_id`) REFERENCES `education_ecm`.`compliance`.`accreditation_standard`(`accreditation_standard_id`);

-- ========= instruction --> curriculum (13 constraint(s)) =========
-- Requires: instruction schema, curriculum schema
ALTER TABLE `education_ecm`.`instruction`.`course_section` ADD CONSTRAINT `fk_instruction_course_section_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`instruction`.`course_section` ADD CONSTRAINT `fk_instruction_course_section_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`instruction`.`course_section` ADD CONSTRAINT `fk_instruction_course_section_prerequisite_rule_id` FOREIGN KEY (`prerequisite_rule_id`) REFERENCES `education_ecm`.`curriculum`.`prerequisite_rule`(`prerequisite_rule_id`);
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ADD CONSTRAINT `fk_instruction_faculty_assignment_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`instruction`.`assignment` ADD CONSTRAINT `fk_instruction_assignment_map_id` FOREIGN KEY (`map_id`) REFERENCES `education_ecm`.`curriculum`.`map`(`map_id`);
ALTER TABLE `education_ecm`.`instruction`.`assignment` ADD CONSTRAINT `fk_instruction_assignment_slo_id` FOREIGN KEY (`slo_id`) REFERENCES `education_ecm`.`curriculum`.`slo`(`slo_id`);
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ADD CONSTRAINT `fk_instruction_grade_entry_slo_id` FOREIGN KEY (`slo_id`) REFERENCES `education_ecm`.`curriculum`.`slo`(`slo_id`);
ALTER TABLE `education_ecm`.`instruction`.`rubric` ADD CONSTRAINT `fk_instruction_rubric_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`instruction`.`rubric` ADD CONSTRAINT `fk_instruction_rubric_plo_id` FOREIGN KEY (`plo_id`) REFERENCES `education_ecm`.`curriculum`.`plo`(`plo_id`);
ALTER TABLE `education_ecm`.`instruction`.`rubric` ADD CONSTRAINT `fk_instruction_rubric_slo_id` FOREIGN KEY (`slo_id`) REFERENCES `education_ecm`.`curriculum`.`slo`(`slo_id`);
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ADD CONSTRAINT `fk_instruction_slo_assessment_map_id` FOREIGN KEY (`map_id`) REFERENCES `education_ecm`.`curriculum`.`map`(`map_id`);
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ADD CONSTRAINT `fk_instruction_slo_assessment_plo_id` FOREIGN KEY (`plo_id`) REFERENCES `education_ecm`.`curriculum`.`plo`(`plo_id`);
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ADD CONSTRAINT `fk_instruction_slo_assessment_slo_id` FOREIGN KEY (`slo_id`) REFERENCES `education_ecm`.`curriculum`.`slo`(`slo_id`);

-- ========= instruction --> enrollment (8 constraint(s)) =========
-- Requires: instruction schema, enrollment schema
ALTER TABLE `education_ecm`.`instruction`.`course_section` ADD CONSTRAINT `fk_instruction_course_section_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ADD CONSTRAINT `fk_instruction_faculty_assignment_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ADD CONSTRAINT `fk_instruction_lms_course_shell_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ADD CONSTRAINT `fk_instruction_final_grade_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `education_ecm`.`enrollment`.`registration`(`registration_id`);
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ADD CONSTRAINT `fk_instruction_final_grade_student_term_record_id` FOREIGN KEY (`student_term_record_id`) REFERENCES `education_ecm`.`enrollment`.`student_term_record`(`student_term_record_id`);
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ADD CONSTRAINT `fk_instruction_attendance_record_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `education_ecm`.`enrollment`.`registration`(`registration_id`);
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ADD CONSTRAINT `fk_instruction_attendance_record_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ADD CONSTRAINT `fk_instruction_slo_assessment_student_term_record_id` FOREIGN KEY (`student_term_record_id`) REFERENCES `education_ecm`.`enrollment`.`student_term_record`(`student_term_record_id`);

-- ========= instruction --> facility (8 constraint(s)) =========
-- Requires: instruction schema, facility schema
ALTER TABLE `education_ecm`.`instruction`.`course_section` ADD CONSTRAINT `fk_instruction_course_section_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`instruction`.`course_section` ADD CONSTRAINT `fk_instruction_course_section_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ADD CONSTRAINT `fk_instruction_section_meeting_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ADD CONSTRAINT `fk_instruction_faculty_assignment_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ADD CONSTRAINT `fk_instruction_faculty_assignment_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ADD CONSTRAINT `fk_instruction_lms_course_shell_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`instruction`.`assignment` ADD CONSTRAINT `fk_instruction_assignment_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ADD CONSTRAINT `fk_instruction_attendance_record_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);

-- ========= instruction --> faculty (9 constraint(s)) =========
-- Requires: instruction schema, faculty schema
ALTER TABLE `education_ecm`.`instruction`.`course_section` ADD CONSTRAINT `fk_instruction_course_section_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ADD CONSTRAINT `fk_instruction_section_meeting_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ADD CONSTRAINT `fk_instruction_faculty_assignment_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`instruction`.`assignment` ADD CONSTRAINT `fk_instruction_assignment_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`instruction`.`submission` ADD CONSTRAINT `fk_instruction_submission_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ADD CONSTRAINT `fk_instruction_grade_entry_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ADD CONSTRAINT `fk_instruction_final_grade_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ADD CONSTRAINT `fk_instruction_attendance_record_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ADD CONSTRAINT `fk_instruction_slo_assessment_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);

-- ========= instruction --> finance (4 constraint(s)) =========
-- Requires: instruction schema, finance schema
ALTER TABLE `education_ecm`.`instruction`.`course_section` ADD CONSTRAINT `fk_instruction_course_section_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`instruction`.`course_section` ADD CONSTRAINT `fk_instruction_course_section_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ADD CONSTRAINT `fk_instruction_faculty_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ADD CONSTRAINT `fk_instruction_faculty_assignment_grant_account_id` FOREIGN KEY (`grant_account_id`) REFERENCES `education_ecm`.`finance`.`grant_account`(`grant_account_id`);

-- ========= instruction --> hr (12 constraint(s)) =========
-- Requires: instruction schema, hr schema
ALTER TABLE `education_ecm`.`instruction`.`course_section` ADD CONSTRAINT `fk_instruction_course_section_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ADD CONSTRAINT `fk_instruction_faculty_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ADD CONSTRAINT `fk_instruction_faculty_assignment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ADD CONSTRAINT `fk_instruction_faculty_assignment_tertiary_faculty_updated_by_user_employee_id` FOREIGN KEY (`tertiary_faculty_updated_by_user_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ADD CONSTRAINT `fk_instruction_lms_course_shell_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`instruction`.`assignment` ADD CONSTRAINT `fk_instruction_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ADD CONSTRAINT `fk_instruction_grade_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ADD CONSTRAINT `fk_instruction_final_grade_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ADD CONSTRAINT `fk_instruction_attendance_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`instruction`.`rubric` ADD CONSTRAINT `fk_instruction_rubric_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`instruction`.`rubric` ADD CONSTRAINT `fk_instruction_rubric_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ADD CONSTRAINT `fk_instruction_slo_assessment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);

-- ========= instruction --> student (5 constraint(s)) =========
-- Requires: instruction schema, student schema
ALTER TABLE `education_ecm`.`instruction`.`submission` ADD CONSTRAINT `fk_instruction_submission_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ADD CONSTRAINT `fk_instruction_grade_entry_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ADD CONSTRAINT `fk_instruction_final_grade_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ADD CONSTRAINT `fk_instruction_attendance_record_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ADD CONSTRAINT `fk_instruction_slo_assessment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);

-- ========= instruction --> studentlife (3 constraint(s)) =========
-- Requires: instruction schema, studentlife schema
ALTER TABLE `education_ecm`.`instruction`.`course_section` ADD CONSTRAINT `fk_instruction_course_section_student_org_id` FOREIGN KEY (`student_org_id`) REFERENCES `education_ecm`.`studentlife`.`student_org`(`student_org_id`);
ALTER TABLE `education_ecm`.`instruction`.`assignment` ADD CONSTRAINT `fk_instruction_assignment_campus_event_id` FOREIGN KEY (`campus_event_id`) REFERENCES `education_ecm`.`studentlife`.`campus_event`(`campus_event_id`);
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ADD CONSTRAINT `fk_instruction_slo_assessment_service_learning_placement_id` FOREIGN KEY (`service_learning_placement_id`) REFERENCES `education_ecm`.`studentlife`.`service_learning_placement`(`service_learning_placement_id`);

-- ========= research --> advancement (2 constraint(s)) =========
-- Requires: research schema, advancement schema
ALTER TABLE `education_ecm`.`research`.`award_account` ADD CONSTRAINT `fk_research_award_account_advancement_fund_id` FOREIGN KEY (`advancement_fund_id`) REFERENCES `education_ecm`.`advancement`.`advancement_fund`(`advancement_fund_id`);
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ADD CONSTRAINT `fk_research_proposal_personnel_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);

-- ========= research --> billing (5 constraint(s)) =========
-- Requires: research schema, billing schema
ALTER TABLE `education_ecm`.`research`.`research_award` ADD CONSTRAINT `fk_research_research_award_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`research`.`research_award` ADD CONSTRAINT `fk_research_research_award_third_party_contract_id` FOREIGN KEY (`third_party_contract_id`) REFERENCES `education_ecm`.`billing`.`third_party_contract`(`third_party_contract_id`);
ALTER TABLE `education_ecm`.`research`.`award_budget` ADD CONSTRAINT `fk_research_award_budget_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `education_ecm`.`billing`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_tuition_charge_id` FOREIGN KEY (`tuition_charge_id`) REFERENCES `education_ecm`.`billing`.`tuition_charge`(`tuition_charge_id`);
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ADD CONSTRAINT `fk_research_proposal_personnel_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `education_ecm`.`billing`.`fee_schedule`(`fee_schedule_id`);

-- ========= research --> compliance (8 constraint(s)) =========
-- Requires: research schema, compliance schema
ALTER TABLE `education_ecm`.`research`.`proposal` ADD CONSTRAINT `fk_research_proposal_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`research`.`research_award` ADD CONSTRAINT `fk_research_research_award_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`research`.`subaward` ADD CONSTRAINT `fk_research_subaward_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `education_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ADD CONSTRAINT `fk_research_irb_protocol_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `education_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ADD CONSTRAINT `fk_research_irb_protocol_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ADD CONSTRAINT `fk_research_irb_protocol_training_program_id` FOREIGN KEY (`training_program_id`) REFERENCES `education_ecm`.`compliance`.`training_program`(`training_program_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `education_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `education_ecm`.`research`.`compliance_event` ADD CONSTRAINT `fk_research_compliance_event_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `education_ecm`.`compliance`.`audit`(`audit_id`);

-- ========= research --> curriculum (4 constraint(s)) =========
-- Requires: research schema, curriculum schema
ALTER TABLE `education_ecm`.`research`.`proposal` ADD CONSTRAINT `fk_research_proposal_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`research`.`proposal` ADD CONSTRAINT `fk_research_proposal_cip_code_id` FOREIGN KEY (`cip_code_id`) REFERENCES `education_ecm`.`curriculum`.`cip_code`(`cip_code_id`);
ALTER TABLE `education_ecm`.`research`.`research_award` ADD CONSTRAINT `fk_research_research_award_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ADD CONSTRAINT `fk_research_irb_protocol_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);

-- ========= research --> facility (11 constraint(s)) =========
-- Requires: research schema, facility schema
ALTER TABLE `education_ecm`.`research`.`proposal` ADD CONSTRAINT `fk_research_proposal_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`research`.`research_award` ADD CONSTRAINT `fk_research_research_award_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`research`.`research_award` ADD CONSTRAINT `fk_research_research_award_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ADD CONSTRAINT `fk_research_principal_investigator_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ADD CONSTRAINT `fk_research_irb_protocol_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`research`.`award_account` ADD CONSTRAINT `fk_research_award_account_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`research`.`award_account` ADD CONSTRAINT `fk_research_award_account_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`research`.`compliance_event` ADD CONSTRAINT `fk_research_compliance_event_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`research`.`compliance_event` ADD CONSTRAINT `fk_research_compliance_event_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);

-- ========= research --> finance (21 constraint(s)) =========
-- Requires: research schema, finance schema
ALTER TABLE `education_ecm`.`research`.`award_budget` ADD CONSTRAINT `fk_research_award_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`research`.`award_budget` ADD CONSTRAINT `fk_research_award_budget_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`research`.`award_budget` ADD CONSTRAINT `fk_research_award_budget_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`research`.`award_budget` ADD CONSTRAINT `fk_research_award_budget_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`research`.`subaward` ADD CONSTRAINT `fk_research_subaward_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `education_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `education_ecm`.`research`.`subaward` ADD CONSTRAINT `fk_research_subaward_grant_account_id` FOREIGN KEY (`grant_account_id`) REFERENCES `education_ecm`.`finance`.`grant_account`(`grant_account_id`);
ALTER TABLE `education_ecm`.`research`.`subaward` ADD CONSTRAINT `fk_research_subaward_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `education_ecm`.`finance`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `education_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_grant_account_id` FOREIGN KEY (`grant_account_id`) REFERENCES `education_ecm`.`finance`.`grant_account`(`grant_account_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `education_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `education_ecm`.`finance`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `education_ecm`.`finance`.`vendor`(`vendor_id`);
ALTER TABLE `education_ecm`.`research`.`award_account` ADD CONSTRAINT `fk_research_award_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`research`.`award_account` ADD CONSTRAINT `fk_research_award_account_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`research`.`award_account` ADD CONSTRAINT `fk_research_award_account_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`research`.`award_account` ADD CONSTRAINT `fk_research_award_account_grant_account_id` FOREIGN KEY (`grant_account_id`) REFERENCES `education_ecm`.`finance`.`grant_account`(`grant_account_id`);
ALTER TABLE `education_ecm`.`research`.`compliance_event` ADD CONSTRAINT `fk_research_compliance_event_grant_account_id` FOREIGN KEY (`grant_account_id`) REFERENCES `education_ecm`.`finance`.`grant_account`(`grant_account_id`);

-- ========= research --> hr (22 constraint(s)) =========
-- Requires: research schema, hr schema
ALTER TABLE `education_ecm`.`research`.`proposal` ADD CONSTRAINT `fk_research_proposal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`research`.`proposal` ADD CONSTRAINT `fk_research_proposal_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`research`.`proposal` ADD CONSTRAINT `fk_research_proposal_proposal_org_unit_id` FOREIGN KEY (`proposal_org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`research`.`research_award` ADD CONSTRAINT `fk_research_research_award_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`research`.`research_award` ADD CONSTRAINT `fk_research_research_award_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`research`.`award_budget` ADD CONSTRAINT `fk_research_award_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ADD CONSTRAINT `fk_research_principal_investigator_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ADD CONSTRAINT `fk_research_principal_investigator_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ADD CONSTRAINT `fk_research_principal_investigator_position_id` FOREIGN KEY (`position_id`) REFERENCES `education_ecm`.`hr`.`position`(`position_id`);
ALTER TABLE `education_ecm`.`research`.`subaward` ADD CONSTRAINT `fk_research_subaward_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ADD CONSTRAINT `fk_research_irb_protocol_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ADD CONSTRAINT `fk_research_irb_protocol_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_position_id` FOREIGN KEY (`position_id`) REFERENCES `education_ecm`.`hr`.`position`(`position_id`);
ALTER TABLE `education_ecm`.`research`.`award_account` ADD CONSTRAINT `fk_research_award_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`research`.`award_account` ADD CONSTRAINT `fk_research_award_account_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ADD CONSTRAINT `fk_research_proposal_personnel_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ADD CONSTRAINT `fk_research_proposal_personnel_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ADD CONSTRAINT `fk_research_proposal_personnel_position_id` FOREIGN KEY (`position_id`) REFERENCES `education_ecm`.`hr`.`position`(`position_id`);
ALTER TABLE `education_ecm`.`research`.`compliance_event` ADD CONSTRAINT `fk_research_compliance_event_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`research`.`compliance_event` ADD CONSTRAINT `fk_research_compliance_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);

-- ========= research --> instruction (3 constraint(s)) =========
-- Requires: research schema, instruction schema
ALTER TABLE `education_ecm`.`research`.`award_budget` ADD CONSTRAINT `fk_research_award_budget_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_faculty_assignment_id` FOREIGN KEY (`faculty_assignment_id`) REFERENCES `education_ecm`.`instruction`.`faculty_assignment`(`faculty_assignment_id`);
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ADD CONSTRAINT `fk_research_proposal_personnel_faculty_assignment_id` FOREIGN KEY (`faculty_assignment_id`) REFERENCES `education_ecm`.`instruction`.`faculty_assignment`(`faculty_assignment_id`);

-- ========= research --> student (1 constraint(s)) =========
-- Requires: research schema, student schema
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ADD CONSTRAINT `fk_research_proposal_personnel_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);

-- ========= student --> billing (2 constraint(s)) =========
-- Requires: student schema, billing schema
ALTER TABLE `education_ecm`.`student`.`hold` ADD CONSTRAINT `fk_student_hold_account_hold_id` FOREIGN KEY (`account_hold_id`) REFERENCES `education_ecm`.`billing`.`account_hold`(`account_hold_id`);
ALTER TABLE `education_ecm`.`student`.`hold` ADD CONSTRAINT `fk_student_hold_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);

-- ========= student --> compliance (23 constraint(s)) =========
-- Requires: student schema, compliance schema
ALTER TABLE `education_ecm`.`student`.`academic_standing` ADD CONSTRAINT `fk_student_academic_standing_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`student`.`degree_progress` ADD CONSTRAINT `fk_student_degree_progress_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ADD CONSTRAINT `fk_student_enrollment_status_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ADD CONSTRAINT `fk_student_enrollment_status_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`student`.`student_test_score` ADD CONSTRAINT `fk_student_student_test_score_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ADD CONSTRAINT `fk_student_transfer_credit_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ADD CONSTRAINT `fk_student_transfer_credit_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`student`.`hold` ADD CONSTRAINT `fk_student_hold_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`student`.`hold` ADD CONSTRAINT `fk_student_hold_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ADD CONSTRAINT `fk_student_leave_of_absence_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ADD CONSTRAINT `fk_student_leave_of_absence_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ADD CONSTRAINT `fk_student_ferpa_consent_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ADD CONSTRAINT `fk_student_ferpa_consent_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`student`.`residency_classification` ADD CONSTRAINT `fk_student_residency_classification_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`student`.`residency_classification` ADD CONSTRAINT `fk_student_residency_classification_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ADD CONSTRAINT `fk_student_visa_immigration_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ADD CONSTRAINT `fk_student_visa_immigration_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`student`.`graduation_application` ADD CONSTRAINT `fk_student_graduation_application_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`student`.`graduation_application` ADD CONSTRAINT `fk_student_graduation_application_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ADD CONSTRAINT `fk_student_disability_accommodation_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ADD CONSTRAINT `fk_student_disability_accommodation_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ADD CONSTRAINT `fk_student_degree_conferral_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ADD CONSTRAINT `fk_student_degree_conferral_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= student --> curriculum (12 constraint(s)) =========
-- Requires: student schema, curriculum schema
ALTER TABLE `education_ecm`.`student`.`degree_progress` ADD CONSTRAINT `fk_student_degree_progress_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`student`.`degree_progress` ADD CONSTRAINT `fk_student_degree_progress_concentration_id` FOREIGN KEY (`concentration_id`) REFERENCES `education_ecm`.`curriculum`.`concentration`(`concentration_id`);
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ADD CONSTRAINT `fk_student_enrollment_status_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`student`.`academic_history` ADD CONSTRAINT `fk_student_academic_history_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ADD CONSTRAINT `fk_student_transfer_credit_articulation_agreement_id` FOREIGN KEY (`articulation_agreement_id`) REFERENCES `education_ecm`.`curriculum`.`articulation_agreement`(`articulation_agreement_id`);
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ADD CONSTRAINT `fk_student_transfer_credit_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ADD CONSTRAINT `fk_student_transfer_credit_transfer_equivalency_id` FOREIGN KEY (`transfer_equivalency_id`) REFERENCES `education_ecm`.`curriculum`.`transfer_equivalency`(`transfer_equivalency_id`);
ALTER TABLE `education_ecm`.`student`.`graduation_application` ADD CONSTRAINT `fk_student_graduation_application_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`student`.`graduation_application` ADD CONSTRAINT `fk_student_graduation_application_concentration_id` FOREIGN KEY (`concentration_id`) REFERENCES `education_ecm`.`curriculum`.`concentration`(`concentration_id`);
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ADD CONSTRAINT `fk_student_disability_accommodation_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ADD CONSTRAINT `fk_student_degree_conferral_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ADD CONSTRAINT `fk_student_degree_conferral_concentration_id` FOREIGN KEY (`concentration_id`) REFERENCES `education_ecm`.`curriculum`.`concentration`(`concentration_id`);

-- ========= student --> enrollment (21 constraint(s)) =========
-- Requires: student schema, enrollment schema
ALTER TABLE `education_ecm`.`student`.`profile` ADD CONSTRAINT `fk_student_profile_enrollment_applicant_id` FOREIGN KEY (`enrollment_applicant_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_applicant`(`enrollment_applicant_id`);
ALTER TABLE `education_ecm`.`student`.`academic_standing` ADD CONSTRAINT `fk_student_academic_standing_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`student`.`academic_standing` ADD CONSTRAINT `fk_student_academic_standing_student_term_record_id` FOREIGN KEY (`student_term_record_id`) REFERENCES `education_ecm`.`enrollment`.`student_term_record`(`student_term_record_id`);
ALTER TABLE `education_ecm`.`student`.`degree_progress` ADD CONSTRAINT `fk_student_degree_progress_student_term_record_id` FOREIGN KEY (`student_term_record_id`) REFERENCES `education_ecm`.`enrollment`.`student_term_record`(`student_term_record_id`);
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ADD CONSTRAINT `fk_student_enrollment_status_student_term_record_id` FOREIGN KEY (`student_term_record_id`) REFERENCES `education_ecm`.`enrollment`.`student_term_record`(`student_term_record_id`);
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ADD CONSTRAINT `fk_student_enrollment_status_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`student`.`academic_history` ADD CONSTRAINT `fk_student_academic_history_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `education_ecm`.`enrollment`.`registration`(`registration_id`);
ALTER TABLE `education_ecm`.`student`.`academic_history` ADD CONSTRAINT `fk_student_academic_history_student_term_record_id` FOREIGN KEY (`student_term_record_id`) REFERENCES `education_ecm`.`enrollment`.`student_term_record`(`student_term_record_id`);
ALTER TABLE `education_ecm`.`student`.`academic_history` ADD CONSTRAINT `fk_student_academic_history_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`student`.`student_test_score` ADD CONSTRAINT `fk_student_student_test_score_enrollment_application_id` FOREIGN KEY (`enrollment_application_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_application`(`enrollment_application_id`);
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ADD CONSTRAINT `fk_student_transfer_credit_transfer_credit_eval_id` FOREIGN KEY (`transfer_credit_eval_id`) REFERENCES `education_ecm`.`enrollment`.`transfer_credit_eval`(`transfer_credit_eval_id`);
ALTER TABLE `education_ecm`.`student`.`hold` ADD CONSTRAINT `fk_student_hold_registration_hold_id` FOREIGN KEY (`registration_hold_id`) REFERENCES `education_ecm`.`enrollment`.`registration_hold`(`registration_hold_id`);
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ADD CONSTRAINT `fk_student_leave_of_absence_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ADD CONSTRAINT `fk_student_leave_of_absence_student_term_record_id` FOREIGN KEY (`student_term_record_id`) REFERENCES `education_ecm`.`enrollment`.`student_term_record`(`student_term_record_id`);
ALTER TABLE `education_ecm`.`student`.`residency_classification` ADD CONSTRAINT `fk_student_residency_classification_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`student`.`graduation_application` ADD CONSTRAINT `fk_student_graduation_application_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`student`.`graduation_application` ADD CONSTRAINT `fk_student_graduation_application_student_term_record_id` FOREIGN KEY (`student_term_record_id`) REFERENCES `education_ecm`.`enrollment`.`student_term_record`(`student_term_record_id`);
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ADD CONSTRAINT `fk_student_disability_accommodation_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ADD CONSTRAINT `fk_student_disability_accommodation_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `education_ecm`.`enrollment`.`registration`(`registration_id`);
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ADD CONSTRAINT `fk_student_degree_conferral_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ADD CONSTRAINT `fk_student_degree_conferral_student_term_record_id` FOREIGN KEY (`student_term_record_id`) REFERENCES `education_ecm`.`enrollment`.`student_term_record`(`student_term_record_id`);

-- ========= student --> facility (5 constraint(s)) =========
-- Requires: student schema, facility schema
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ADD CONSTRAINT `fk_student_enrollment_status_campus_id` FOREIGN KEY (`campus_id`) REFERENCES `education_ecm`.`facility`.`campus`(`campus_id`);
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ADD CONSTRAINT `fk_student_leave_of_absence_campus_id` FOREIGN KEY (`campus_id`) REFERENCES `education_ecm`.`facility`.`campus`(`campus_id`);
ALTER TABLE `education_ecm`.`student`.`graduation_application` ADD CONSTRAINT `fk_student_graduation_application_campus_id` FOREIGN KEY (`campus_id`) REFERENCES `education_ecm`.`facility`.`campus`(`campus_id`);
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ADD CONSTRAINT `fk_student_disability_accommodation_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ADD CONSTRAINT `fk_student_degree_conferral_campus_id` FOREIGN KEY (`campus_id`) REFERENCES `education_ecm`.`facility`.`campus`(`campus_id`);

-- ========= student --> faculty (3 constraint(s)) =========
-- Requires: student schema, faculty schema
ALTER TABLE `education_ecm`.`student`.`academic_history` ADD CONSTRAINT `fk_student_academic_history_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`student`.`graduation_application` ADD CONSTRAINT `fk_student_graduation_application_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ADD CONSTRAINT `fk_student_disability_accommodation_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);

-- ========= student --> finance (4 constraint(s)) =========
-- Requires: student schema, finance schema
ALTER TABLE `education_ecm`.`student`.`hold` ADD CONSTRAINT `fk_student_hold_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ADD CONSTRAINT `fk_student_leave_of_absence_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `education_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `education_ecm`.`student`.`graduation_application` ADD CONSTRAINT `fk_student_graduation_application_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `education_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ADD CONSTRAINT `fk_student_disability_accommodation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= student --> hr (15 constraint(s)) =========
-- Requires: student schema, hr schema
ALTER TABLE `education_ecm`.`student`.`academic_standing` ADD CONSTRAINT `fk_student_academic_standing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ADD CONSTRAINT `fk_student_enrollment_status_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ADD CONSTRAINT `fk_student_enrollment_status_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`student`.`student_test_score` ADD CONSTRAINT `fk_student_student_test_score_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ADD CONSTRAINT `fk_student_transfer_credit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`student`.`hold` ADD CONSTRAINT `fk_student_hold_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`student`.`hold` ADD CONSTRAINT `fk_student_hold_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ADD CONSTRAINT `fk_student_leave_of_absence_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ADD CONSTRAINT `fk_student_ferpa_consent_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`student`.`residency_classification` ADD CONSTRAINT `fk_student_residency_classification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ADD CONSTRAINT `fk_student_visa_immigration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`student`.`graduation_application` ADD CONSTRAINT `fk_student_graduation_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ADD CONSTRAINT `fk_student_disability_accommodation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ADD CONSTRAINT `fk_student_degree_conferral_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ADD CONSTRAINT `fk_student_degree_conferral_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);

-- ========= student --> instruction (5 constraint(s)) =========
-- Requires: student schema, instruction schema
ALTER TABLE `education_ecm`.`student`.`academic_history` ADD CONSTRAINT `fk_student_academic_history_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);
ALTER TABLE `education_ecm`.`student`.`academic_history` ADD CONSTRAINT `fk_student_academic_history_final_grade_id` FOREIGN KEY (`final_grade_id`) REFERENCES `education_ecm`.`instruction`.`final_grade`(`final_grade_id`);
ALTER TABLE `education_ecm`.`student`.`academic_history` ADD CONSTRAINT `fk_student_academic_history_grade_entry_id` FOREIGN KEY (`grade_entry_id`) REFERENCES `education_ecm`.`instruction`.`grade_entry`(`grade_entry_id`);
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ADD CONSTRAINT `fk_student_disability_accommodation_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `education_ecm`.`instruction`.`assignment`(`assignment_id`);
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ADD CONSTRAINT `fk_student_disability_accommodation_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);

-- ========= student --> research (1 constraint(s)) =========
-- Requires: student schema, research schema
ALTER TABLE `education_ecm`.`student`.`academic_history` ADD CONSTRAINT `fk_student_academic_history_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);

-- ========= student --> studentlife (1 constraint(s)) =========
-- Requires: student schema, studentlife schema
ALTER TABLE `education_ecm`.`student`.`academic_history` ADD CONSTRAINT `fk_student_academic_history_service_learning_placement_id` FOREIGN KEY (`service_learning_placement_id`) REFERENCES `education_ecm`.`studentlife`.`service_learning_placement`(`service_learning_placement_id`);

-- ========= studentlife --> advancement (1 constraint(s)) =========
-- Requires: studentlife schema, advancement schema
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ADD CONSTRAINT `fk_studentlife_campus_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `education_ecm`.`advancement`.`campaign`(`campaign_id`);

-- ========= studentlife --> billing (10 constraint(s)) =========
-- Requires: studentlife schema, billing schema
ALTER TABLE `education_ecm`.`studentlife`.`housing_assignment` ADD CONSTRAINT `fk_studentlife_housing_assignment_account_hold_id` FOREIGN KEY (`account_hold_id`) REFERENCES `education_ecm`.`billing`.`account_hold`(`account_hold_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ADD CONSTRAINT `fk_studentlife_housing_application_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `education_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ADD CONSTRAINT `fk_studentlife_housing_application_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ADD CONSTRAINT `fk_studentlife_dining_enrollment_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `education_ecm`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ADD CONSTRAINT `fk_studentlife_dining_enrollment_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ADD CONSTRAINT `fk_studentlife_health_visit_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ADD CONSTRAINT `fk_studentlife_student_org_third_party_contract_id` FOREIGN KEY (`third_party_contract_id`) REFERENCES `education_ecm`.`billing`.`third_party_contract`(`third_party_contract_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ADD CONSTRAINT `fk_studentlife_conduct_sanction_account_hold_id` FOREIGN KEY (`account_hold_id`) REFERENCES `education_ecm`.`billing`.`account_hold`(`account_hold_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ADD CONSTRAINT `fk_studentlife_conduct_sanction_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ADD CONSTRAINT `fk_studentlife_service_learning_placement_tuition_charge_id` FOREIGN KEY (`tuition_charge_id`) REFERENCES `education_ecm`.`billing`.`tuition_charge`(`tuition_charge_id`);

-- ========= studentlife --> compliance (3 constraint(s)) =========
-- Requires: studentlife schema, compliance schema
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ADD CONSTRAINT `fk_studentlife_immunization_record_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ADD CONSTRAINT `fk_studentlife_conduct_case_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ADD CONSTRAINT `fk_studentlife_conduct_sanction_training_program_id` FOREIGN KEY (`training_program_id`) REFERENCES `education_ecm`.`compliance`.`training_program`(`training_program_id`);

-- ========= studentlife --> curriculum (10 constraint(s)) =========
-- Requires: studentlife schema, curriculum schema
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ADD CONSTRAINT `fk_studentlife_immunization_record_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ADD CONSTRAINT `fk_studentlife_student_org_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ADD CONSTRAINT `fk_studentlife_campus_event_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ADD CONSTRAINT `fk_studentlife_campus_event_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ADD CONSTRAINT `fk_studentlife_conduct_case_section_id` FOREIGN KEY (`section_id`) REFERENCES `education_ecm`.`curriculum`.`section`(`section_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ADD CONSTRAINT `fk_studentlife_conduct_sanction_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ADD CONSTRAINT `fk_studentlife_service_learning_placement_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ADD CONSTRAINT `fk_studentlife_service_learning_placement_degree_requirement_id` FOREIGN KEY (`degree_requirement_id`) REFERENCES `education_ecm`.`curriculum`.`degree_requirement`(`degree_requirement_id`);
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ADD CONSTRAINT `fk_studentlife_service_learning_placement_section_id` FOREIGN KEY (`section_id`) REFERENCES `education_ecm`.`curriculum`.`section`(`section_id`);
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ADD CONSTRAINT `fk_studentlife_service_learning_placement_slo_id` FOREIGN KEY (`slo_id`) REFERENCES `education_ecm`.`curriculum`.`slo`(`slo_id`);

-- ========= studentlife --> enrollment (15 constraint(s)) =========
-- Requires: studentlife schema, enrollment schema
ALTER TABLE `education_ecm`.`studentlife`.`housing_assignment` ADD CONSTRAINT `fk_studentlife_housing_assignment_enrollment_application_id` FOREIGN KEY (`enrollment_application_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_application`(`enrollment_application_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_assignment` ADD CONSTRAINT `fk_studentlife_housing_assignment_matriculation_id` FOREIGN KEY (`matriculation_id`) REFERENCES `education_ecm`.`enrollment`.`matriculation`(`matriculation_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_assignment` ADD CONSTRAINT `fk_studentlife_housing_assignment_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ADD CONSTRAINT `fk_studentlife_housing_application_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ADD CONSTRAINT `fk_studentlife_housing_application_enrollment_application_id` FOREIGN KEY (`enrollment_application_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_application`(`enrollment_application_id`);
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ADD CONSTRAINT `fk_studentlife_dining_enrollment_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ADD CONSTRAINT `fk_studentlife_counseling_case_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ADD CONSTRAINT `fk_studentlife_campus_event_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ADD CONSTRAINT `fk_studentlife_event_attendance_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ADD CONSTRAINT `fk_studentlife_conduct_case_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ADD CONSTRAINT `fk_studentlife_conduct_case_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `education_ecm`.`enrollment`.`registration`(`registration_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ADD CONSTRAINT `fk_studentlife_conduct_case_student_term_record_id` FOREIGN KEY (`student_term_record_id`) REFERENCES `education_ecm`.`enrollment`.`student_term_record`(`student_term_record_id`);
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ADD CONSTRAINT `fk_studentlife_service_learning_placement_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ADD CONSTRAINT `fk_studentlife_service_learning_placement_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `education_ecm`.`enrollment`.`registration`(`registration_id`);
ALTER TABLE `education_ecm`.`studentlife`.`health_appointment` ADD CONSTRAINT `fk_studentlife_health_appointment_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);

-- ========= studentlife --> facility (9 constraint(s)) =========
-- Requires: studentlife schema, facility schema
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ADD CONSTRAINT `fk_studentlife_residence_hall_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ADD CONSTRAINT `fk_studentlife_residence_room_floor_id` FOREIGN KEY (`floor_id`) REFERENCES `education_ecm`.`facility`.`floor`(`floor_id`);
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ADD CONSTRAINT `fk_studentlife_residence_room_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ADD CONSTRAINT `fk_studentlife_health_visit_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ADD CONSTRAINT `fk_studentlife_counseling_case_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ADD CONSTRAINT `fk_studentlife_campus_event_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ADD CONSTRAINT `fk_studentlife_campus_event_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`studentlife`.`health_appointment` ADD CONSTRAINT `fk_studentlife_health_appointment_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`studentlife`.`health_appointment` ADD CONSTRAINT `fk_studentlife_health_appointment_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);

-- ========= studentlife --> faculty (4 constraint(s)) =========
-- Requires: studentlife schema, faculty schema
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ADD CONSTRAINT `fk_studentlife_counseling_case_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ADD CONSTRAINT `fk_studentlife_student_org_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ADD CONSTRAINT `fk_studentlife_conduct_case_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ADD CONSTRAINT `fk_studentlife_service_learning_placement_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);

-- ========= studentlife --> finance (26 constraint(s)) =========
-- Requires: studentlife schema, finance schema
ALTER TABLE `education_ecm`.`studentlife`.`housing_assignment` ADD CONSTRAINT `fk_studentlife_housing_assignment_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_assignment` ADD CONSTRAINT `fk_studentlife_housing_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_assignment` ADD CONSTRAINT `fk_studentlife_housing_assignment_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ADD CONSTRAINT `fk_studentlife_housing_application_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ADD CONSTRAINT `fk_studentlife_housing_application_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ADD CONSTRAINT `fk_studentlife_residence_hall_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ADD CONSTRAINT `fk_studentlife_residence_room_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` ADD CONSTRAINT `fk_studentlife_dining_plan_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ADD CONSTRAINT `fk_studentlife_dining_enrollment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ADD CONSTRAINT `fk_studentlife_dining_enrollment_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ADD CONSTRAINT `fk_studentlife_dining_enrollment_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ADD CONSTRAINT `fk_studentlife_health_visit_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ADD CONSTRAINT `fk_studentlife_health_visit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ADD CONSTRAINT `fk_studentlife_health_visit_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ADD CONSTRAINT `fk_studentlife_counseling_case_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ADD CONSTRAINT `fk_studentlife_student_org_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ADD CONSTRAINT `fk_studentlife_student_org_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ADD CONSTRAINT `fk_studentlife_campus_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ADD CONSTRAINT `fk_studentlife_campus_event_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ADD CONSTRAINT `fk_studentlife_campus_event_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ADD CONSTRAINT `fk_studentlife_event_attendance_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ADD CONSTRAINT `fk_studentlife_conduct_sanction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ADD CONSTRAINT `fk_studentlife_conduct_sanction_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `education_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ADD CONSTRAINT `fk_studentlife_conduct_sanction_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ADD CONSTRAINT `fk_studentlife_service_learning_placement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`studentlife`.`health_appointment` ADD CONSTRAINT `fk_studentlife_health_appointment_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);

-- ========= studentlife --> hr (15 constraint(s)) =========
-- Requires: studentlife schema, hr schema
ALTER TABLE `education_ecm`.`studentlife`.`housing_assignment` ADD CONSTRAINT `fk_studentlife_housing_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ADD CONSTRAINT `fk_studentlife_housing_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ADD CONSTRAINT `fk_studentlife_residence_hall_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ADD CONSTRAINT `fk_studentlife_health_visit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ADD CONSTRAINT `fk_studentlife_immunization_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ADD CONSTRAINT `fk_studentlife_counseling_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ADD CONSTRAINT `fk_studentlife_student_org_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ADD CONSTRAINT `fk_studentlife_campus_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ADD CONSTRAINT `fk_studentlife_campus_event_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ADD CONSTRAINT `fk_studentlife_event_attendance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ADD CONSTRAINT `fk_studentlife_conduct_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ADD CONSTRAINT `fk_studentlife_conduct_sanction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ADD CONSTRAINT `fk_studentlife_conduct_sanction_tertiary_conduct_waived_by_staff_employee_id` FOREIGN KEY (`tertiary_conduct_waived_by_staff_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ADD CONSTRAINT `fk_studentlife_service_learning_placement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`studentlife`.`health_appointment` ADD CONSTRAINT `fk_studentlife_health_appointment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);

-- ========= studentlife --> instruction (1 constraint(s)) =========
-- Requires: studentlife schema, instruction schema
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ADD CONSTRAINT `fk_studentlife_conduct_case_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `education_ecm`.`instruction`.`submission`(`submission_id`);

-- ========= studentlife --> research (3 constraint(s)) =========
-- Requires: studentlife schema, research schema
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ADD CONSTRAINT `fk_studentlife_health_visit_irb_protocol_id` FOREIGN KEY (`irb_protocol_id`) REFERENCES `education_ecm`.`research`.`irb_protocol`(`irb_protocol_id`);
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ADD CONSTRAINT `fk_studentlife_service_learning_placement_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ADD CONSTRAINT `fk_studentlife_service_learning_placement_irb_protocol_id` FOREIGN KEY (`irb_protocol_id`) REFERENCES `education_ecm`.`research`.`irb_protocol`(`irb_protocol_id`);

-- ========= studentlife --> student (25 constraint(s)) =========
-- Requires: studentlife schema, student schema
ALTER TABLE `education_ecm`.`studentlife`.`housing_assignment` ADD CONSTRAINT `fk_studentlife_housing_assignment_disability_accommodation_id` FOREIGN KEY (`disability_accommodation_id`) REFERENCES `education_ecm`.`student`.`disability_accommodation`(`disability_accommodation_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_assignment` ADD CONSTRAINT `fk_studentlife_housing_assignment_leave_of_absence_id` FOREIGN KEY (`leave_of_absence_id`) REFERENCES `education_ecm`.`student`.`leave_of_absence`(`leave_of_absence_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_assignment` ADD CONSTRAINT `fk_studentlife_housing_assignment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ADD CONSTRAINT `fk_studentlife_housing_application_disability_accommodation_id` FOREIGN KEY (`disability_accommodation_id`) REFERENCES `education_ecm`.`student`.`disability_accommodation`(`disability_accommodation_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ADD CONSTRAINT `fk_studentlife_housing_application_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ADD CONSTRAINT `fk_studentlife_housing_application_tertiary_housing_roommate_preference_2_student_profile_id` FOREIGN KEY (`tertiary_housing_roommate_preference_2_student_profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ADD CONSTRAINT `fk_studentlife_dining_enrollment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ADD CONSTRAINT `fk_studentlife_health_visit_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ADD CONSTRAINT `fk_studentlife_immunization_record_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `education_ecm`.`student`.`hold`(`hold_id`);
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ADD CONSTRAINT `fk_studentlife_immunization_record_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ADD CONSTRAINT `fk_studentlife_counseling_case_academic_standing_id` FOREIGN KEY (`academic_standing_id`) REFERENCES `education_ecm`.`student`.`academic_standing`(`academic_standing_id`);
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ADD CONSTRAINT `fk_studentlife_counseling_case_leave_of_absence_id` FOREIGN KEY (`leave_of_absence_id`) REFERENCES `education_ecm`.`student`.`leave_of_absence`(`leave_of_absence_id`);
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ADD CONSTRAINT `fk_studentlife_counseling_case_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ADD CONSTRAINT `fk_studentlife_student_org_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ADD CONSTRAINT `fk_studentlife_org_membership_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ADD CONSTRAINT `fk_studentlife_event_attendance_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ADD CONSTRAINT `fk_studentlife_conduct_case_academic_standing_id` FOREIGN KEY (`academic_standing_id`) REFERENCES `education_ecm`.`student`.`academic_standing`(`academic_standing_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ADD CONSTRAINT `fk_studentlife_conduct_case_enrollment_status_id` FOREIGN KEY (`enrollment_status_id`) REFERENCES `education_ecm`.`student`.`enrollment_status`(`enrollment_status_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ADD CONSTRAINT `fk_studentlife_conduct_case_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `education_ecm`.`student`.`hold`(`hold_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ADD CONSTRAINT `fk_studentlife_conduct_case_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ADD CONSTRAINT `fk_studentlife_conduct_sanction_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `education_ecm`.`student`.`hold`(`hold_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ADD CONSTRAINT `fk_studentlife_conduct_sanction_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ADD CONSTRAINT `fk_studentlife_service_learning_placement_degree_progress_id` FOREIGN KEY (`degree_progress_id`) REFERENCES `education_ecm`.`student`.`degree_progress`(`degree_progress_id`);
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ADD CONSTRAINT `fk_studentlife_service_learning_placement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`studentlife`.`health_appointment` ADD CONSTRAINT `fk_studentlife_health_appointment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);

