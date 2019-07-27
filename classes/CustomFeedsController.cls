/**
 * Created by spring4 on 17-07-2019.
 */

public without sharing class CustomFeedsController {
    @AuraEnabled
    public static Integer getFeedCount(String recordId){
        Integer count = 0;
        try {
            List<FeedItem> feeds = [SELECT Id FROM FeedItem WHERE ParentId = :recordId];
            count = feeds.size();
        }catch (Exception ex){

        }
        return count;
    }
}