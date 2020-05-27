public class DemoVFActionController {
    public String vfMessage {get; set;}
    public DemoVFActionController(){
        System.debug('DemoVFActionController');
        vfMessage = 'Constructor';
    }
    
    public DemoVFActionController(ApexPages.StandardController stdController) {
        System.debug('DemoVFActionController');
        vfMessage = 'Constructor';
    }
    
    public void updateMessageApex(){
        vfMessage = 'updateMessageApex';
    }
}