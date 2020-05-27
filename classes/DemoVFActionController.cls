public class DemoVFActionController {
    public String message {get; set;}
    public DemoVFActionController(ApexPages.StandardController stdController) {
        System.debug('DemoVFActionController message: '+message);
        message = 'Constructor';
        System.debug('DemoVFActionController message: '+message);
    }
    
    public PageReference updateMessageApex(){
        System.debug('DemoVFActionController updateMessageApex message: '+message);
        message = 'updateMessageApex';
        System.debug('DemoVFActionController updateMessageApex message:' +message);
        return null;
    }
}