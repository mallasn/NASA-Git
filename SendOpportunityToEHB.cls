public with sharing class SendOpportunityToEHB {

	public static Map<String,String> SendOpportunityToEHB(List<Opportunity> opps, Map<String, String> calloutResponse){

		Http h = new Http();
		// Instantiate a new HTTP request, specify the method (POST) as well as the endpoint
		HttpRequest req = new HttpRequest();  
		req.setTimeout(10000);
		req.setHeader('Content-Type','application/json');
		req.setHeader('Authorization', 'AuthHeader');
		req.setEndpoint('URL' + 'MethodName');
		req.setMethod('POST');

        SalesforceEHBDataRequest request = new SalesforceEHBDataRequest();
        request.SalesforceEHBData = new cls_SalesforceEHBData();
        request.SalesforceEHBData.opportunities = new List<cls_opportunities>();

//        cls_opportunities optyData = new cls_opportunities();
        List<cls_opportunities> lo = new List<cls_opportunities>();

        //String oppId;
        for(Opportunity opty : opps){
            //Opportunity Data
            //Opportunity opty = [Select Id,Agency__c,EHBId__c,Name,Contract__c,CloseDate,Account.Id from Opportunity where Id = :oppId];
            cls_opportunities optyData = new cls_opportunities();
            optyData.id = opty.EHBId__c;
            optyData.title = opty.Name;
            optyData.contract = opty.Contract__c;
            optyData.agency = opty.Agency__c;
            optyData.fiscalYear = opty.CloseDate;
            optyData.sfId = opty.Id;

            //Firm Data
            FirmData fData = new FirmData();
            Account act = [Select Id,Firm_Type__c,Name,BillingStreet,BillingCity,BillingState,BillingPostalCode,Website,
                                    EIN__c,DUNS__c,Phone,Disadvantaged__c,Woman_Owned__c,Disadvantaged_Women_Owned__c,Firm_ID__c,
                                    Hubzone__c,Veteran_Owned__c,Disabled_Veteran_Owned__c from Account where Id = :opty.Account.Id];
            fdata.id = act.Firm_ID__c;
            fdata.type = act.Firm_Type__c;
            fdata.name = act.Name;
            fdata.street = act.BillingStreet;
            fdata.city = act.BillingCity;
            fdata.st = act.BillingState;
            fdata.zip = act.BillingPostalCode;
            fdata.url = act.Website;
            fdata.ein = act.EIN__c;
            fdata.duns = act.DUNS__c;
            fdata.phone = act.Phone;
            fdata.minorityOwned = act.Disadvantaged__c;
            fdata.women = act.Woman_Owned__c;
            fdata.minorityWomen = act.Disadvantaged_Women_Owned__c;
            fdata.hubzone = act.Hubzone__c;
            fdata.veteran = act.Veteran_Owned__c;
            fdata.disabled = act.Disabled_Veteran_Owned__c;
            fdata.sfId = act.Id;
            optyData.firm = fData;

            //Awards Data
            List<OpportunityAward__c> optyAward = [Select Related_Award__r.Award_ID__c,Related_Award__r.Id,Related_Award__r.Award_Type__c,
                                                            Related_Award__r.Name,Related_Award__r.Proposal__c,Related_Award__r.Proposal_Tite_del__c,
                                                            Related_Award__r.Agency__c,Related_Award__r.Program__c,Related_Award__r.Phase__c,
                                                            Related_Award__r.Amount__c,Related_Award__r.Solicitation_Id__c,Related_Award__r.Technology_Area__c,
                                                            Related_Award__r.Contract_Status__c from OpportunityAward__c where Related_Opportunity__c = :opty.Id];
            List<Award> awardList = new List<Award>();
            for(Integer i = 0; i<optyAward.size(); i++){
                Award awardData = new Award();
                awardData.id = optyAward.get(i).Related_Award__r.Award_ID__c;
                awardData.sfId = optyAward.get(i).Related_Award__r.Id;
                awardData.type = optyAward.get(i).Related_Award__r.Award_Type__c;
                awardData.contract = optyAward.get(i).Related_Award__r.Name;
                awardData.proposal = optyAward.get(i).Related_Award__r.Proposal__c;
                awardData.title = optyAward.get(i).Related_Award__r.Proposal_Tite_del__c;
                awardData.agency = optyAward.get(i).Related_Award__r.Agency__c;
                awardData.program = optyAward.get(i).Related_Award__r.Program__c;
                awardData.phase = optyAward.get(i).Related_Award__r.Phase__c;
                awardData.amount = Integer.valueOf(optyAward.get(i).Related_Award__r.Amount__c);
                awardData.solicitation = optyAward.get(i).Related_Award__r.Solicitation_Id__c;
                awardData.techArea = optyAward.get(i).Related_Award__r.Technology_Area__c;
                awardData.contact_status = optyAward.get(i).Related_Award__r.Contract_Status__c;
                awardList.add(awardData);
            }
            optyData.awards = awardList;

            //Contacts Data
            List<OpportunityContactRole> optyContacts = [Select ContactId,Role,Contact.FirstName, Contact.LastName, Contact.Phone,Contact.ContactId__c,
                                                                Contact.Email,Contact.Id From OpportunityContactRole where OpportunityId = :opty.Id];
            List<Contact> contactList = new List<Contact>();
            for(Integer i = 0; i<optyContacts.size(); i++){
                    Contact contactData = new Contact();
                contactData.firstName = optyContacts.get(i).Contact.FirstName;
                contactData.lastName = optyContacts.get(i).Contact.LastName;
                contactData.phone = optyContacts.get(i).Contact.Phone;
                contactData.email = optyContacts.get(i).Contact.Email;
                contactData.id = optyContacts.get(i).Contact.ContactId__c;
                contactData.sfId = optyContacts.get(i).Contact.Id;
                contactData.role = optyContacts.get(i).Role;
                contactList.add(contactData);
            }
            optyData.contacts = contactList;
            lo.add(optyData);
        }
        request.SalesforceEHBData.opportunities = lo;
        System.debug('optyData----' + JSON.serialize(request));

        /*HttpResponse response = h.send(req);
        System.debug('++ response code Status Update' + response.getStatusCode());
        if(response.getStatusCode() != 200){
            System.debug('++ response' + response.getBody());
        }
        else{
            calloutResponse.put(oppId,'Success');
        }*/
		return calloutResponse;
	}

    public class SalesforceEHBDataRequest{
        cls_SalesforceEHBData SalesforceEHBData {get;set;}
    }


    public class cls_SalesforceEHBData {
        List<cls_opportunities> opportunities;
    }    

    public class cls_opportunities{
    	public String id {get;set;}
    	public String title {get;set;}
    	public String contract {get;set;}
    	public String agency {get;set;}
    	public Date fiscalYear {get;set;}
    	public String sfId {get;set;}
    	public firmData firm {get;set;}
		public List<Award> awards{get;set;}
		public List<Contact> contacts{get;set;}
    }

	public class FirmData {

        public String id{get;set;}
        public String type{get;set;}
        public String name{get;set;}
        public String street{get;set;}
        public String city{get;set;}
        public String st{get;set;}
        public String zip{get;set;}
        public String url{get;set;}
        public String ein{get;set;}
        public String duns{get;set;}
        public String phone{get;set;}
        public Boolean minorityOwned{get;set;}
        public Boolean women{get;set;}
        public Boolean minorityWomen{get;set;}
        public Boolean hubzone{get;set;}
        public Boolean veteran{get;set;}
        public Boolean disabled{get;set;}
        public String sfId{get;set;}

    }

	public class Award {
    
        public String id{get;set;}
        public String sfId{get;set;}
        public String type{get;set;}
        public String contract{get;set;}
        public String proposal{get;set;}
        public String title{get;set;}
        public String agency{get;set;}
        public String program{get;set;}
        public String phase{get;set;}
        public Integer amount{get;set;}
        public String solicitation{get;set;}
        public String techArea{get;set;}
        public String contact_status{get;set;}        
    }

    public class Contact {
    
        public String firstName{get;set;}
        public String lastName{get;set;}
        public String phone {get;set;}
        public String email {get;set;}
        public String id {get;set;}
        public String sfId {get;set;}
        public String role {get;set;}   
    }   

}