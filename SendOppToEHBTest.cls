@isTest
private class SendOppToEHBTest {
	
	@isTest static void test_method_one() {

		Account act = new Account();
		act.Firm_ID__c = '111111';
		act.Firm_Type__c = 'NASA';
		act.Name = 'Busek Company, Inc';
		act.BillingStreet = '11 Tech Circle';
		act.BillingCity = 'Natick';
		act.BillingState = 'MA';
		act.BillingPostalCode = '01760';
		act.Website = 'www.testwebsite.com';
		act.EIN__c = '042881247';
		act.DUNS__c = '185739591';
		act.Phone = '5086555565';
		act.Disadvantaged__c = False;
		act.Woman_Owned__c = False;
        act.Disadvantaged_Women_Owned__c = False;
		act.Hubzone__c = False;
		act.Veteran_Owned__c = False;
		act.Disabled_Veteran_Owned__c = False;
		insert act;


		Opportunity opp = new Opportunity();
		opp.StageName = 'Negotiation';
		opp.Transferred_to_EHB__c = False;
		opp.AccountId = act.Id;
		opp.CloseDate = Date.valueOf('2020-01-01');
		opp.Name = 'Test Opp';
		insert opp;

		Awards__c award = new Awards__c();
		award.Award_ID__c = '2222';
        award.Award_Type__c = 'NASA';
        award.Name = 'NNX14CC24C';
        award.Proposal__c = 'E1.01-9072';
        award.Proposal_Tite_del__c = 'Hall Effect Thruster';
        award.Agency__c = 'NASA';
        award.Program__c = 'SBIR';
        award.Phase__c = '2';
        award.Amount__c = 100000;
        award.Solicitation_Id__c = 'SBIR_12_P1_S';
        award.Technology_Area__c = 'TestingTechArea1';
        award.Contract_Status__c = 'Active';
        insert award;

        Contact con = new Contact();
		con.FirstName = 'AAA';
		con.LastName = 'BBB';
		con.Phone = '888-999-5555';
		con.Email = 'a@email.com';
		con.ContactId__c = '32232323';
		insert con;


        OpportunityAward__c optyAward = new OpportunityAward__c();
        optyAward.Related_Award__c = award.Id;
        optyAward.Related_Opportunity__c = opp.Id;
        insert optyAward;

		OpportunityContactRole ocr = new OpportunityContactRole();
		ocr.OpportunityId = opp.Id;
		ocr.ContactId = con.Id;
		ocr.Role = 'POC';
		insert ocr;

		SendOppToEHBBatch b = new SendOppToEHBBatch();
		database.executebatch(b,10);

	}

	
}