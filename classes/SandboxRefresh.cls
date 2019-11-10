global class SandboxRefresh implements System.SandboxPostCopy {
    public static final String STANDARD_STATIC_RESOURCE_NAME = 'SandboxPostCopyTemplate';

    global void runApexClass(System.SandboxContext sandboxContext) {
        System.debug('SandboxRefresh.runApexClass runApexClass');
        runApexClass(sandboxContext.sandboxName());
    }

    global static void runApexClass(String sandboxName) {
        String jsonString = readStaticResource(sandboxName);
        System.debug('SandboxRefresh.runApexClass jsonString: ' + jsonString);
        if (jsonString != null) {
            SandboxRefreshTemplate template = getTemplate(jsonString);
            new SandboxRefreshProvisionPlugin().execute(template);
            new SandboxRefreshDataCreationPlugin().execute(template);
            new SandboxRefreshInvalidateEmailPlugin().execute(template);
            new SandboxRefreshEncryptFieldsDataPlugin().execute(template);
        }
    }

    public static SandboxRefreshTemplate getTemplate(String jsonString) {
        System.debug('SandboxRefresh.getTemplate getTemplate: ');
        SandboxRefreshTemplate template = (SandboxRefreshTemplate) JSON.deserialize(jsonString, SandboxRefreshTemplate.class);
        return template;
    }

    public static String readStaticResource(String staticResourceName) {
        String jsonString;
        try{
            String searchNameString = '%'+staticResourceName+'%';
            StaticResource staticResource = [SELECT Id, Name, Body FROM StaticResource WHERE Name like : searchNameString LIMIT 1];
            jsonString = staticResource.Body.toString();
            System.debug('SandboxRefresh.readStaticResource jsonString: ' + jsonString);
            System.debug(jsonString);
            return jsonString;
        }catch (Exception e){
            System.debug(e.getMessage());
        }

        try {
            StaticResource standardStaticResource = [SELECT Id, Name, Body FROM StaticResource WHERE Name like :'%' + STANDARD_STATIC_RESOURCE_NAME + '%' LIMIT 1];
            jsonString = standardStaticResource.Body.toString();
            System.debug('SandboxRefresh.readStaticResource jsonString: ' + jsonString);
            return jsonString;
        } catch (Exception e) {
            System.debug(e.getMessage());
        }
        return jsonString;
    }
}