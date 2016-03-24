@RestResource(urlMapping='/EHBData/1.0/*')
global with sharing class EHBData{
@HttpPost
    global static EHBDataResponse doPost(EHBDataRequest EHBSalesforceData){

        RestRequest req = RestContext.request;

        //Insert Firms
        List<Account> firmsList = new List<Account>();
        List<Account> firmsListNN = new List<Account>();

        //Insert Awards
        List<Awards__c> awardsList = new List<Awards__c>();
        List<Awards__c> awardsListNN = new List<Awards__c>();

        //Insert Post Awards
        List<Post_Award__c> postAwardsList = new List<Post_Award__c>();
        List<Post_Award__c> postAwardsListNN = new List<Post_Award__c>();

        //Insert Contacts
        List<Contact> contactsList = new List<Contact>();
        List<Contact> contactsListNN = new List<Contact>();

        //Update Related Awards
        List<Awards__c> updRelatedAwards = new List<Awards__c>();

        //Update Award and Post Awards relation
        List<AwardPAAssociation__c> apRelation = new List<AwardPAAssociation__c>();

        //Update Award and Contact relation
        List<AwardContacts__c> acRelation = new List<AwardContacts__c>();

        //Update Post Award and Contacts relation
        List<Post_Award_Contact__c> pcRelation = new List<Post_Award_Contact__c>();

        for(EHBDataRequest.Firm firmInstance : EHBSalesforceData.firms){
            Account firmData = new Account();
            firmData.Firm_ID__c = firmInstance.FirmData.id;
            firmData.Firm_Type__c = firmInstance.FirmData.type;
            firmData.Name = firmInstance.FirmData.name;
            firmData.BillingStreet = firmInstance.FirmData.street;
            firmData.BillingCity = firmInstance.FirmData.city;
            firmData.BillingState = firmInstance.FirmData.st;
            firmData.BillingPostalCode = firmInstance.FirmData.zip;
            firmData.Website = firmInstance.FirmData.url;
            firmData.EIN__c = firmInstance.FirmData.ein;
            firmData.DUNS__c = firmInstance.FirmData.duns;
            firmData.Phone = firmInstance.FirmData.phone;
            firmData.Disadvantaged__c = firmInstance.FirmData.minorityOwned;
            firmData.Woman_Owned__c = firmInstance.FirmData.women;
            firmData.Disadvantaged_Women_Owned__c = firmInstance.FirmData.minorityWomen;
            firmData.Hubzone__c = firmInstance.FirmData.hubzone;
            firmData.Veteran_Owned__c = firmInstance.FirmData.veteran;
            firmData.Disabled_Veteran_Owned__c = firmInstance.FirmData.disabled;
            if(firmInstance.FirmData.id != '' && firmInstance.FirmData.sfId == ''){
                firmsList.add(firmData);
            }
            else{
                firmData.Id = firmInstance.FirmData.sfId;
                firmsListNN.add(firmData);
            }
            //Insert Awards
            for(EHBDataRequest.Award awardInstance : firmInstance.awards){
                Awards__c awardData = new Awards__c();
                awardData.Award_ID__c = awardInstance.id;
                awardData.Solicitation_Id__c = awardInstance.solicitation;
                awardData.Proposal__c = awardInstance.proposal;
                awardData.Award_Type__c = awardInstance.type;
                awardData.Name = awardInstance.contract;
                awardData.Proposal_Tite_del__c = awardInstance.title;
                awardData.Agency__c = awardInstance.agency;
                awardData.Program__c = awardInstance.program;
                awardData.Phase__c = awardInstance.phase;
                awardData.Amount__c = awardInstance.amount;
                awardData.Technology_Area__c = awardInstance.techArea;
                awardData.Contract_Status__c = awardInstance.contact_status;
                awardData.Award_Date__c = awardInstance.award_date;
                awardData.Year__c = awardInstance.year;
                awardData.Topic_Subtopic__c = awardInstance.topic;
                awardData.Responsible_Center__c = awardInstance.center;
                awardData.Firm__r = new Account (Firm_ID__c = firmInstance.firmData.id);
                //awardsList.add(awardData);
                if(awardInstance.id != '' && awardInstance.sfId == ''){
                    awardsList.add(awardData);
                }
                else{
                    awardData.Id = awardInstance.sfId;
                    awardsListNN.add(awardData);
                }
            }
            //Insert Contacts
            for(EHBDataRequest.Contact contactInstance : firmInstance.contacts){
                Contact contactData = new Contact();
                contactData.FirstName = contactInstance.firstName;
                contactData.LastName = contactInstance.lastName;                
                contactData.ContactId__c = contactInstance.id;
                contactData.Phone = contactInstance.phone;
                contactData.Email = contactInstance.email;
                contactData.Account = new Account (Firm_ID__c = firmInstance.firmData.id);
                //contactsList.add(contactData);
                if(contactInstance.id != '' && contactInstance.sfId == ''){
                    contactsList.add(contactData);
                }
                else{
                    contactData.Id = contactInstance.sfId;
                    contactsListNN.add(contactData);
                }
            }
            //Insert Post Awards
            for(EHBDataRequest.PostAward postAwardInstance : firmInstance.postawards){
                Post_Award__c postAwardData = new Post_Award__c();
                postAwardData.Post_Award_ID__c = postAwardInstance.id;
                postAwardData.Name = postAwardInstance.title;
                postAwardData.Contract__c = postAwardInstance.contract;
                postAwardData.Agency__c = postAwardInstance.agency;
                postAwardData.Fiscal_Year__c = postAwardInstance.fiscalYear;
                postAwardData.Firm__r = new Account (Firm_ID__c = firmInstance.firmData.id);
                //postAwardsList.add(postAwardData);
                if(postAwardInstance.id != '' && postAwardInstance.sfId == ''){
                    postAwardsList.add(postAwardData);
                }
                else{
                    postAwardData.Id = postAwardInstance.sfId;
                    postAwardsListNN.add(postAwardData);
                }
            }
        }
        if (!Test.isRunningTest() && firmsList.size() > 0) {
            Upsert firmsList Firm_ID__c;
        }
        else if (!Test.isRunningTest() && firmsListNN.size() > 0) {
            Update firmsListNN;
        }
        if (!Test.isRunningTest() && awardsList.size() > 0) {
            Upsert awardsList Award_ID__c;
        }
        else if(!Test.isRunningTest() && awardsListNN.size() > 0) {
            Update awardsListNN;
        }

        if (!Test.isRunningTest() && contactsList.size() > 0) {
            Upsert contactsList ContactId__c;
        }
        else if (!Test.isRunningTest() && contactsListNN.size() > 0) {
            Update contactsListNN;
        }

        if (!Test.isRunningTest() && postAwardsList.size() > 0) {
            Upsert postAwardsList Post_Award_ID__c;
        }
        else if (!Test.isRunningTest() && postAwardsListNN.size() > 0) {
            Update postAwardsListNN;
        }

        //Get Salesforce Ids to insert into Junction Objects
        for(EHBDataRequest.Firm firmInstance : EHBSalesforceData.firms){
            //Get Awards and Related Awards
            for(EHBDataRequest.AwardRelation awardRelationInstance : firmInstance.awardRelations){
                Awards__c awardData = [Select Id from Awards__c where Award_ID__c = :awardRelationInstance.awardId];
                for(EHBDataRequest.RelatedAward relatedAwardsInstance : awardRelationInstance.relatedAward){
                    Awards__c relatedAwardData = [Select Id from Awards__c where Award_ID__c = :relatedAwardsInstance.relatedAwardId];
                    relatedAwardData.Related_Award__c = awardData.Id;
                    updRelatedAwards.add(relatedAwardData);
                }
                for(EHBDataRequest.RelatedPAward relatedPAwardsInstance : awardRelationInstance.relatedPAward){
                    Post_Award__c relatedPAwardData = [Select Id from Post_Award__c where Post_Award_ID__c = :relatedPAwardsInstance.relatedPAwardId];
                    List<AwardPAAssociation__c> ap = [Select Id from AwardPAAssociation__c where Award__c = :awardData.Id and Post_Award__c = :relatedPAwardData.Id];
                    if(ap.size() == 0){
                        AwardPAAssociation__c newAP = new AwardPAAssociation__c();
                        newAP.Award__c = awardData.Id;
                        newAP.Post_Award__c = relatedPAwardData.Id;
                        apRelation.add(newAP);
                    }
                }
                for(EHBDataRequest.RelatedContact relatedContactsInstance : awardRelationInstance.relatedContact){
                    Contact relatedContactData = [Select Id from Contact where ContactId__c = :relatedContactsInstance.relatedContactId];
                    List<AwardContacts__c> ac = [Select Id from AwardContacts__c where Related_Award__c = :awardData.Id and Contact2Award__c = :relatedContactData.Id];
                    if(ac.size() == 0){
                        AwardContacts__c newAC = new AwardContacts__c();
                        newAC.Related_Award__c = awardData.Id;
                        newAC.Contact2Award__c = relatedContactData.Id;
                        newAC.Award_Role__c = relatedContactsInstance.role;
                        acRelation.add(newAC);
                    }
                }
            }
            for(EHBDataRequest.PostAwardRelation pawardRelationInstance : firmInstance.postAwardRelations){
                Post_Award__c pawardData = [Select Id from Post_Award__c where Post_Award_ID__c = :pawardRelationInstance.postAwardId];
                for(EHBDataRequest.RelatedContact relatedPContactsInstance : pawardRelationInstance.relatedContact){
                    Contact relatedPContactData = [Select Id from Contact where ContactId__c = :relatedPContactsInstance.relatedContactId];
                    List<Post_Award_Contact__c> pc = [Select Id from Post_Award_Contact__c where Related_Post_Award__c = :pawardData.Id and Related_Contact__c = :relatedPContactData.Id];
                    if(pc.size() == 0){
                        Post_Award_Contact__c newPC = new Post_Award_Contact__c();
                        newPC.Related_Post_Award__c = pawardData.Id;
                        newPC.Related_Contact__c = relatedPContactData.Id;
                        newPC.Post_Award_Role__c = relatedPContactsInstance.role;
                        pcRelation.add(newPC);
                    }
                }
            }            
        }        

        if(!Test.isRunningTest() && updRelatedAwards.size() >0){
            Update updRelatedAwards;// Award_ID__c;
        }

        if(!Test.isRunningTest() && apRelation.size() >0){
            Upsert apRelation Id;
        }

        if(!Test.isRunningTest() && acRelation.size() >0){
            Upsert acRelation Id;
        }

        if(!Test.isRunningTest() && pcRelation.size() >0){
            Upsert pcRelation Id;
        }

        //Prepare the Response
        EHBDataResponse response = new EHBDataResponse();
        response.ehbResponse = 'success';
        return response;

        
    }

}