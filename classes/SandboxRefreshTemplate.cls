public class SandboxRefreshTemplate {
    public List<UserRecord> provisionUserRecords;
    public List<SObjectRecord> sObjectRecords;
    public List<InvalidateEmailsObject> inValidateEmailsObjects;
    public String notificationEmails;
    public class UserRecord{
        public String userName;
        public String profile;
        public boolean isActive;
    }

    public class SObjectRecord{
        public String sObjectName;
        public Map<String,String> attributes;
        public String reference;
    }

    public class InvalidateEmailsObject{
        public String sObjectName;
        public String emailFields;
    }
}