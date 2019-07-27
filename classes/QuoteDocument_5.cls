public with sharing class QuoteDocument_5 {
    public Id quoteId {get; set;}
    
    public QuoteDocument_5(ApexPages.StandardController controller) {
        quoteId = controller.getId();
    }
}