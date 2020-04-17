/**
 * Created by cshah on 17/04/20.
 */

public class InvocableMethodsQueueable implements Queueable {
    List<Account> accounts;

    public InvocableMethodsQueueable(List<Account> accounts) {
        this.accounts = accounts;
    }

    public void execute(QueueableContext context) {
        String recordId;
        String rating;
        for (Account account : accounts) {
            recordId = account.Id;
            rating = account.Rating;
        }

        Http http = new Http();
        HttpRequest httpRequest = new HttpRequest();
        httpRequest.setEndpoint('https://basic-authentication-ws.herokuapp.com/echo');
        httpRequest.setMethod('POST');

        Map<String, Object> data = new Map<String, Object>{
                'recordId' => recordId,
                'rating' => rating
        };
        httpRequest.setBody(JSON.serialize(data));

        HttpResponse httpResponse = http.send(httpRequest);
        if (httpResponse.getStatusCode() == 200) {
            System.debug(' InvocableMethods.notifyRatingChange Received data httpResponse.getBody():' + httpResponse.getBody());
        } else {
            System.debug(' InvocableMethods.notifyRatingChange Request failed. ');
        }
    }
}