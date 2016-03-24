global class SendOppToEHBBatch implements Database.Batchable<sObject> {
	
	String query;
	Map<String, String> calloutResponse = new Map<String, String>();
	
	global SendOppToEHBBatch() {
		
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator([Select Id,Agency__c,EHBId__c,Name,Contract__c,CloseDate,Account.Id 
											from Opportunity where StageName = 'Negotiation' and Transferred_to_EHB__c = False]);
	}

   	global void execute(Database.BatchableContext BC, List<sObject> opportunities) {
   		List<Opportunity> getOpportunities = (List<Opportunity>) opportunities;
   		SendOpportunityToEHB.SendOpportunityToEHB(getOpportunities, calloutResponse);

		List<Opportunity> optToUpdate = new List<Opportunity>();
		Opportunity optUpdate;
								
		for(String s: calloutResponse.KeySet()){
			String reqres = calloutResponse.get(s);
			if(reqres.contains('Success')){
				optUpdate = [Select Transferred_to_EHB__c from Opportunity where Id = :s];
				optUpdate.Transferred_to_EHB__c = true;
				optToUpdate.add(optUpdate);
			}
		}
		update optToUpdate;

	}
	
	global void finish(Database.BatchableContext BC) {
		AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,TotalJobItems, CreatedBy.Email
							FROM AsyncApexJob WHERE Id =:BC.getJobId()];

        // Send an email to the Apex job's submitter notifying of job completion.
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
 //         String[] toAddresses = new String[] {a.CreatedBy.Email};
		String[] toAddresses = new String[] {'satya.malla@reisystems.com'};
		mail.setToAddresses(toAddresses);
		mail.setSubject('Subscriber details ' + a.Status);
		mail.setPlainTextBody ('The batch Apex job processed ' + a.TotalJobItems + ' batches with '+ a.NumberOfErrors + ' failures.');
//		Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
	}
	
}