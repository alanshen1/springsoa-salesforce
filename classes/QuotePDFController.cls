public class QuotePDFController {
    public Quote quoteObj {get; set;}
    public Opportunity oppObj {get; set;}
    public List<QuoteLineItem> quoteLineItems {get; set;}
    
    public QuotePDFController(ApexPages.StandardController controller){
        Id recordId = controller.getRecord().Id;
        
        //Quote Object
        List<Schema.FieldSetMember> fsMember = getQuoteFields();
        String quoteQuery = 'SELECT ';
        for(Schema.FieldSetMember f : fsMember) {
            quoteQuery += f.getFieldPath() + ', ';
        }
        quoteQuery += ' OpportunityId ';
        quoteQuery += ' FROM Quote LIMIT 1';
        quoteObj = Database.query(quoteQuery);
        
        //Opportunity Object
        Id oppId = quoteObj.OpportunityId;
        fsMember = getOppFields();
        String oppQuery = 'SELECT ';
        for(Schema.FieldSetMember f : fsMember) {
            oppQuery += f.getFieldPath() + ', ';
        }
        oppQuery = oppQuery.substring(0,oppQuery.length()-2);
        oppQuery += ' FROM Opportunity Where Id = :oppId LIMIT 1';
        oppObj = Database.query(oppQuery);
        
        //OLI Object - InProgress
        quoteLineItems = [SELECT Id, Quantity, UnitPrice, Discount, TotalPrice, LineNumber FROM QuoteLineItem where QuoteId = :recordId];
    }
    public List<Schema.FieldSetMember> getQuoteFields(){
        return SObjectType.Quote.FieldSets.Quote_Document_Fields.getFields();
    }
    public List<Schema.FieldSetMember> getOppFields(){
        return SObjectType.Opportunity.FieldSets.Quote_Document_Fields.getFields();
    }
    
}