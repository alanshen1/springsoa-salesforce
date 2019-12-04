/**
 * Created by Spring7 on 12/4/2019.
 */

public class NewContactController {

    @AuraEnabled
    public static Contact getContact(Id accountRecordId, Id recordTypeId){
        System.debug('recordTypeId'+recordTypeId);
        Contact contact 		= 	new Contact();
        Account account = [
                SELECT Id, Name, Phone, Fax,BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry,BillingLatitude,BillingLongitude,BillingGeocodeAccuracy
                FROM Account
                WHERE Id = :accountRecordId
                LIMIT 1
        ];
        contact.AccountId				=	accountRecordId;
        getContactFromAccount(contact,account);
        System.debug(JSON.serialize(contact));
        return contact;
    }

    @TestVisible
    private static void getContactFromAccount(Contact contact,Account account){
        contact.MailingStreet			= 	account.BillingStreet;
        contact.MailingCity				= 	account.BillingCity;
        contact.MailingState			= 	account.BillingState;
        contact.MailingPostalCode		= 	account.BillingPostalCode;
        contact.MailingCountry			= 	account.BillingCountry;
        contact.MailingLatitude			= 	account.BillingLatitude;
        contact.MailingLongitude		= 	account.BillingLongitude;
        contact.MailingGeocodeAccuracy	= 	account.BillingGeocodeAccuracy;
        contact.Phone					= 	account.Phone;
        contact.Fax						= 	account.Fax;
    }
}