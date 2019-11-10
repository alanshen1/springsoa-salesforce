public without sharing class SandboxRefreshProvisionPlugin implements SandboxRefreshPlugin{

    public String execute(SandboxRefreshTemplate sandboxRefreshTemplate){
        try {
            System.debug('SandboxRefreshProvisionPlugin.execute sandboxRefreshTemplate: ' + JSON.serialize(sandboxRefreshTemplate));
            List<SandboxRefreshTemplate.UserRecord> userRecords = sandboxRefreshTemplate.provisionUserRecords;
            Map<String,SandboxRefreshTemplate.UserRecord> userRecordMap = getUserNameMap(userRecords);
            Map<String,Id> userProfiles = getUserProfiles();
            List<User> users = [
                    SELECT Email,IsActive,ProfileId,UserName
                    FROM User
                    WHERE UserName in : userRecordMap.keySet()
            ];
            if (!users.isEmpty()) {
                for(User userObj : users){
                    SandboxRefreshTemplate.UserRecord userRecord = userRecordMap.get(userObj.UserName);
                    userObj.Email = userObj.Email.subStringBefore('.invalid');
                    userObj.ProfileId = userProfiles.containsKey(userRecord.Profile) ?userProfiles.get(userRecord.Profile) : userObj.ProfileId;
                    userObj.IsActive = userRecord.IsActive;
                }
                System.debug('SandboxRefreshProvisionPlugin.execute users: ' + JSON.serialize(users));
                update users;
            }
        } catch(Exception e) {
            System.debug('SandboxRefreshProvisionPlugin.execute error ' + e.getMessage() + e.getStackTraceString() );
            return 'ERROR : ' + e.getMessage() + e.getStackTraceString();
        }
        return 'SandboxRefreshProvisionPlugin.execute executed successfully ';
    }

    private static Map<String,SandboxRefreshTemplate.UserRecord> getUserNameMap(List<SandboxRefreshTemplate.UserRecord> userRecords){
        System.debug('SandboxRefreshProvisionPlugin.getUserNameMap userRecords: ' + JSON.serialize(userRecords));
        Map<String,SandboxRefreshTemplate.UserRecord> userRecordMap = new Map<String,SandboxRefreshTemplate.UserRecord>();
        for(SandboxRefreshTemplate.UserRecord userRecord : userRecords){
            userRecordMap.put(userRecord.UserName,userRecord);
        }
        return userRecordMap;
    }

    private static Map<String,Id> getUserProfiles(){
        System.debug('SandboxRefreshProvisionPlugin.getUserProfiles getUserProfiles: ');
        Map<String,Id> profileNames = new Map<String,Id>();
        for(Profile profile : [SELECT Id,Name from Profile]){
            profileNames.put(profile.Name,Profile.Id);
        }
        return profileNames;
    }
}