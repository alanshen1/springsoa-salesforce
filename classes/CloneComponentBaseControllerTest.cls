/**
 * Created by Spring7 on 9/23/2019.
 */
@isTest
public with sharing class CloneComponentBaseControllerTest {

    @isTest
    public static void getRecordTest(){
        Account acc = new Account(name = 'test acc');
        insert acc;

        Test.startTest();
        Account testAccount = (Account)CloneComponentBaseController.getRecord(acc.Id,'CloneAccount','Account');
        Test.stopTest();
        System.assertEquals(acc.Id,testAccount.Id);

    }
}