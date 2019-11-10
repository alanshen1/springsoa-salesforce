public class SandboxRefreshEncryptFieldsDataBatch implements Database.Batchable<sObject> {
    private String sObjectName;
    private List<SandboxRefreshTemplate.SObjectField> sObjectFields;
    private static final List<String> RANDOM_CHARACTERS = new List<String>{
            'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
    };

    public SandboxRefreshEncryptFieldsDataBatch(String sObjectName, List<SandboxRefreshTemplate.SObjectField> sObjectFields) {
        this.sObjectName = sObjectName;
        this.sObjectFields = sObjectFields;
        System.debug('SandboxRefreshEncryptFieldsDataBatch.SandboxRefreshEncryptFieldsDataBatch sObjectName: ' + sObjectName);
        System.debug('SandboxRefreshEncryptFieldsDataBatch.SandboxRefreshEncryptFieldsDataBatch sObjectFields: ' + sObjectFields);
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id';
        for (SandboxRefreshTemplate.SObjectField sObjectfield : sObjectFields) {
            query += ', ' + sObjectfield.fieldName;
        }
        query += ' FROM ' + sObjectName;
        System.debug('SandboxRefreshEncryptFieldsDataBatch.start query: ' + query);
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext bc, List<sObject> sObjectRecords) {
        System.debug('SandboxRefreshEncryptFieldsDataBatch.execute sObjectRecords: ' + JSON.serialize(sObjectRecords));
        for (sObject sObjectRecord : sObjectRecords) {
            System.debug('SandboxRefreshEncryptFieldsDataBatch.execute sObjectRecord: ' + JSON.serialize(sObjectRecord));
            for (SandboxRefreshTemplate.SObjectField sObjectField : sObjectFields) {
                System.debug('SandboxRefreshEncryptFieldsDataBatch.execute sObjectField: ' + sObjectField);
                sObjectRecord.put(sObjectField.fieldName, getEncryptedValue(sObjectField.format));
            }
        }
        System.debug('SandboxRefreshEncryptFieldsDataBatch.execute sObjectRecords: ' + JSON.serialize(sObjectRecords));
        update sObjectRecords;
    }

    public static String replaceNumber(String str) {
        if (str.length() <= 1) {
            return str;
        }

        if (str.substring(0, 1) == '{' && str.length() >= 3 && str.substring(1, 2) == 'N' && str.substring(2, 3) == '}') {
            return generateRandomNumber() + replaceNumber(str.substring(3, str.length()));
        }

        return str.substring(0, 1) + replaceNumber(str.substring(1, str.length()));
    }

    public static String replaceCharacter(String str) {
        if (str.length() <= 1) {
            return str;
        }

        if (str.substring(0, 1) == '{' && str.length() >= 3 && str.substring(1, 2) == 'S' && str.substring(2, 3) == '}') {
            return getEncryptedCharacter() + replaceCharacter(str.substring(3, str.length()));
        }

        return str.substring(0, 1) + replaceCharacter(str.substring(1, str.length()));
    }

    public static Integer generateRandomNumber() {
        Integer randomNumber = Integer.valueof((Math.random() * 10));
        return randomNumber;
    }

    public static String getEncryptedCharacter() {
        Integer listSize = RANDOM_CHARACTERS.size() - 1;
        Integer randomNumber = Integer.valueof((Math.random() * listSize));
        return RANDOM_CHARACTERS[randomNumber];
    }
    public static String getEncryptedValue(String str) {
        str = replaceCharacter(str);
        str = replaceNumber(str);
        return str;
    }
    public void finish(Database.BatchableContext bc) {
    }
}