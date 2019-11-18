public class MyController
{
 public static final Id recordId = '0012E000026DWVZ';
 
 public PageReference save()
 { 
   //perpare JSON and then callout
   // String rowJSON =  '[{"attributes":{"type":"Account","url":"/services/data/v47.0/sobjects/Account/0012E000026DWVZQA4"},"Id":"0012E000026DWVZQA4","Name":"Test Change data capture 2"}]';
    MyWebService.performRESTCallout(recordId);

  //navigate to view page
  PageReference pg =  (new ApexPages.StandardController (new Account(Id=recordId))).view();
  pg.setRedirect(true);
  return pg;
 }
}