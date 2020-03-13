/**
 * Created by spring2 on 13-03-2020.
 */

public without sharing class createDefaultOpportunitiesOnAccount {

    Public static final String Default_Residential_Opportunity = 'Default Residential Opportunity';
    Public static final String Default_Commercial_Opportunity = 'Default Commercial Opportunity';
    Public static final String Stage_Prospecting = 'Prospecting';

    public Static void createOpportunities(List<Account> accounts) {
        List<Opportunity> opportunities = new List<Opportunity>();
        for (Account account : accounts) {
            Opportunity residentialOpportunity = new Opportunity();
            residentialOpportunity.AccountId = account.Id;
            residentialOpportunity.Name = Default_Residential_Opportunity;
            residentialOpportunity.StageName = Stage_Prospecting;
            residentialOpportunity.CloseDate = System.Today() + 5;
            opportunities.add(residentialOpportunity);

            Opportunity commercialOpportunity = new Opportunity();
            commercialOpportunity.AccountId = account.Id;
            commercialOpportunity.Name = Default_Commercial_Opportunity;
            residentialOpportunity.StageName = Stage_Prospecting;
            residentialOpportunity.CloseDate = System.Today() + 5;
            opportunities.add(commercialOpportunity);
        }
        try {
            insert opportunities;
            System.debug(' createDefaultOpportunitiesOnAccount.createOpportunities opportunities : ' + JSON.serialize(opportunities));
        } catch (system.DmlException e) {
            system.debug(e);
        }
    }
}