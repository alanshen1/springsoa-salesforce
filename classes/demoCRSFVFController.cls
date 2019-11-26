/**
 * Created by spring4 on 26-11-2019.
 */

public with sharing class demoCRSFVFController {
    public void updateAccountName(){
        String accId = apexpages.currentpage().getparameters().get('id');
        String name = apexpages.currentpage().getparameters().get('name');
        Account acc = new Account();
        acc.Id = accId;
        acc.Name = name;
        update acc;
    }
}