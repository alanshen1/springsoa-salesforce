trigger AttachmentTrgr on Attachment (before insert,after insert,before update) {
    if(Trigger.isBefore && Trigger.isInsert){
        for(Attachment attchObj : Trigger.New){
            attchObj.ParentId = '0062E00001EAOPUQA5';
        }
    }
}