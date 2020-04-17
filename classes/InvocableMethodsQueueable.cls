/**
 * Created by cshah on 17/04/20.
 */

public class InvocableMethodsQueueable implements Queueable, Database.AllowsCallouts {
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

        InvocableMethods.notifyRatingChangeCall(recordId, rating);
    }
}