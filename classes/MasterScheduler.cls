/**
 * Created by Chintan Shah on 11/10/2019.
 */

public with sharing class MasterScheduler implements Schedulable  {

    private static final Integer BATCH_FREQUENCY_IN_MINUTES = 5; // ideally it should goto custom settings.
    private static final String JOB_NAME = 'MasterScheduler';

    public void execute(SchedulableContext schedulableContext) {
        System.debug('MasterScheduler.execute : ');
        rescheduleJob( JOB_NAME, BATCH_FREQUENCY_IN_MINUTES );
    }

    public static void rescheduleJob(String jobName, Integer batchFrequencyMinutes) {
        System.debug('MasterScheduler.rescheduleJob : jobName ' + jobName + ' batchFrequencyMinutes ' + batchFrequencyMinutes );
        abortJobByName(jobName);
        Datetime dt = system.now().addMinutes(batchFrequencyMinutes);
        String cronExpression = '0 ' + dt.minute() + ' ' + dt.hour() + ' ' + dt.day() + ' ' + dt.month() + ' ? ' + ' ' + dt.year();
        System.debug('MasterScheduler.rescheduleJob : cronExpression ' + cronExpression );
        System.schedule(jobName, cronExpression, new MasterScheduler());
    }

    public static void abortJobByName(String jobName) {
        System.debug('MasterScheduler.abortJobByName : jobName ' + jobName );
        List<CronTrigger> cronTriggers = [select id, TimesTriggered, NextFireTime, CronExpression, PreviousFireTime, StartTime, EndTime from CronTrigger];
        for(CronTrigger cronTrigger : cronTriggers ) {
            abortJobById(cronTrigger.Id);
        }
    }

    public static void abortJobById(String jobId) {
        System.debug('MasterScheduler.abortJobById : jobId ' + jobId );
        System.abortJob(jobId);
    }


}