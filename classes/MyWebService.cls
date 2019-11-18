public class MyWebService
{
    @future(callout = true)
    public static void performRESTCallout(string recordId)
    {
    Account account = new Account();
    account.Id = recordId;
    account.Phone = '';
    update account;
    }
}