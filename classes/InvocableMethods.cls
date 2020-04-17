/**
 * Created by cshah on 17/04/20.
 */

public without sharing class InvocableMethods {

    @InvocableMethod(Label='Notify Rating Change')
    public static void checkRating(AccountData[] accounts) {
        System.debug(' InvocableMethods.checkRating accounts: ' + JSON.serialize(accounts));
        if (accounts.isEmpty()) {
            System.debug(LoggingLevel.ERROR, 'Account Data not available. ');
            return;
        }

        AccountData accountData;
        for (AccountData account : accounts) {
            accountData = account;
            break;
        }

        notifyRatingChangeFuture(accountData.recordId, accountData.rating);
        // notifyRatingChangeQueueable(accountData.recordId);
    }

    @Future(Callout=true)
    private static void notifyRatingChangeFuture(String recordId, String rating) {
        notifyRatingChangeCall(recordId, rating);
    }

    private static void notifyRatingChangeQueueable(String recordId) {
        System.enqueueJob(new InvocableMethodsQueueable([SELECT Rating FROM Account WHERE Id = :recordId]));
    }

    public static void notifyRatingChangeCall(String recordId, String rating) {
        Http http = new Http();
        HttpRequest httpRequest = new HttpRequest();
        httpRequest.setEndpoint('https://basic-authentication-ws.herokuapp.com/echo');
        httpRequest.setMethod('POST');

        Map<String, Object> data = new Map<String, Object>{
                'message' => recordId + ':' + rating
        };
        httpRequest.setBody(JSON.serialize(data));
        httpRequest.setHeader('Content-Type', 'application/json');

        HttpResponse httpResponse = http.send(httpRequest);
        if (httpResponse.getStatusCode() == 200) {
            System.debug(' InvocableMethods.notifyRatingChange Received data httpResponse.getBody():' + httpResponse.getBody());
        } else {
            System.debug(' InvocableMethods.notifyRatingChange Request failed. ');
        }
    }

    public class AccountData {
        @InvocableVariable(Required=true)
        public String recordId;

        @InvocableVariable(Required=true)
        public String rating;
    }

}