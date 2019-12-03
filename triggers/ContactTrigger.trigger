/**
 * Created by spring4 on 03-12-2019.
 */

trigger ContactTrigger on Contact (after insert, after update) {
    EncryptAndDecryptHelper.processData(Trigger.new);
}