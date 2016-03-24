@isTest
private class EHBDataTest {
	
	@isTest static void test_method_one() {

		EHBDataRequest request = new EHBDataRequest();
		request.firms = new List<EHBDataRequest.Firm>();

		EHBDataRequest.Firm f = new EHBDataRequest.Firm();

		f.awards = new List<EHBDataRequest.Award>();
		f.contacts = new List<EHBDataRequest.Contact>();
		f.awardRelations = new List<EHBDataRequest.AwardRelation>();
		f.postAwardRelations = new List<EHBDataRequest.PostAwardRelation>();
		f.postAwards = new List<EHBDataRequest.PostAward>();
		f.firmData = new EHBDataRequest.FirmData();

		EHBDataRequest.FirmData fd = new EHBDataRequest.FirmData();
		fd.id = '';
                fd.type = '';
                fd.name = '';
                fd.street = '';
                fd.city = '';
                fd.st = '';
                fd.zip = '';
                fd.url = 'www.google.com';
                fd.ein = '';
                fd.duns = '';
                fd.phone = '';
                fd.minorityOwned = False;
                fd.women = False;
                fd.minorityWomen = False;
                fd.hubzone = False;
                fd.veteran = False;
                fd.disabled = False;
                fd.sfId = '';		
		f.firmData = fd;


		EHBDataRequest.Award award = new EHBDataRequest.Award();
                award.id = '';
                award.sfId = '';
                award.type = '';
                award.contract = '';
                award.proposal = '';
                award.title = '';
                award.agency = '';
                award.program = '';
                award.phase = '';
                award.amount = 100;
                award.solicitation = '';
                award.techArea = '';
                award.contact_status = '';
                award.award_date = Date.valueOf('2012-08-24');
                award.year = '';
                award.topic = '';
                award.center = '';		
		f.awards.add(award);

		EHBDataRequest.Contact cont = new EHBDataRequest.Contact();
                cont.firstName = 'AAA';
                cont.lastName = 'AAA';
                cont.phone  = '888-888-9999';
                cont.email  = 'cccc@email.com';
                cont.id = '';
                cont.sfId = '';
                f.contacts.add(cont);

		EHBDataRequest.PostAward pa = new EHBDataRequest.PostAward();
                pa.id ='';
                pa.title ='';
                pa.contract ='';
                pa.agency ='';
                pa.fiscalYear ='';
                pa.sfId ='';
                f.postAwards.add(pa);

		EHBDataRequest.AwardRelation ar = new EHBDataRequest.AwardRelation();
		ar.relatedAward = new List<EHBDataRequest.RelatedAward>();
		EHBDataRequest.RelatedAward ra = new EHBDataRequest.RelatedAward();
		ra.relatedAwardId = '';
		ar.awardId = '';
		ar.relatedAward.add(ra);


		ar.relatedContact = new List<EHBDataRequest.RelatedContact>();
		EHBDataRequest.RelatedContact rc = new EHBDataRequest.RelatedContact();
		rc.relatedContactId = '';
		rc.role = 'POC';
		ar.relatedContact.add(rc);

		ar.relatedPAward = new List<EHBDataRequest.RelatedPAward>();
		EHBDataRequest.RelatedPAward rpa = new EHBDataRequest.RelatedPAward();
		rpa.relatedPAwardId = '';
		ar.relatedPAward.add(rpa);



		EHBDataRequest.PostAwardRelation par = new EHBDataRequest.PostAwardRelation();
		par.postAwardId = '';
		par.relatedContact = new List<EHBDataRequest.RelatedContact>();
		EHBDataRequest.RelatedContact prc = new EHBDataRequest.RelatedContact();
		prc.relatedContactId = '';
		prc.role = 'POC';
		par.relatedContact.add(prc);		

		ar.awardId='';
		f.awardRelations.add(ar);
		f.postAwardRelations.add(par);

		request.firms.add(f);
	}
	
}