global with sharing class EHBDataRequest {

    global List<Firm> firms {get;set;}
    
    global class Firm {

        global FirmData firmData{get;set;}
        global List<Award> awards{get;set;}
        global List<Contact> contacts{get;set;}
        global List<PostAward> postAwards{get;set;}
        global List<AwardRelation> awardRelations{get;set;}
        global List<PostAwardRelation> postAwardRelations{get;set;}

    }

    global class Award {
    
        global String id{get;set;}
        global String sfId{get;set;}
        global String type{get;set;}
        global String contract{get;set;}
        global String proposal{get;set;}
        global String title{get;set;}
        global String agency{get;set;}
        global String program{get;set;}
        global String phase{get;set;}
        global Integer amount{get;set;}
        global String solicitation{get;set;}
        global String techArea{get;set;}
        global String contact_status{get;set;}
        global Date award_date{get;set;}
        global String year{get;set;}
        global String topic{get;set;}
        global String center{get;set;}

    }

    global class Contact {
    
        global String firstName{get;set;}
        global String lastName{get;set;}
        global String phone {get;set;}
        global String email {get;set;}
        global String id{get;set;}
        global String sfId{get;set;}
        
    }    

    global class AwardRelation {

        global String awardId{get;set;}
        global List<RelatedAward> relatedAward {get;set;}
        global List<RelatedPAward> relatedPAward {get;set;}
        global List<RelatedContact> relatedContact {get;set;}

    }

    global class PostAwardRelation {

        global String postAwardId{get;set;}
        global List<RelatedContact> relatedContact{get;set;}

    }

    global class FirmData {

        global String id{get;set;}
        global String type{get;set;}
        global String name{get;set;}
        global String street{get;set;}
        global String city{get;set;}
        global String st{get;set;}
        global String zip{get;set;}
        global String url{get;set;}
        global String ein{get;set;}
        global String duns{get;set;}
        global String phone{get;set;}
        global Boolean minorityOwned{get;set;}
        global Boolean women{get;set;}
        global Boolean minorityWomen{get;set;}
        global Boolean hubzone{get;set;}
        global Boolean veteran{get;set;}
        global Boolean disabled{get;set;}
        global String sfId{get;set;}

    }

    global class PostAward {

        global String id{get;set;}
        global String title{get;set;}
        global String contract{get;set;}
        global String agency{get;set;}
        global String fiscalYear{get;set;}
        global String sfId{get;set;}

    }

    global class RelatedAward {

        global String relatedAwardId{get;set;}

    }

    global class RelatedPAward {

        global String relatedPAwardId{get;set;}

    }

    global class RelatedContact {

        global String relatedContactId{get;set;}
        global String role{get;set;}

    }    


}