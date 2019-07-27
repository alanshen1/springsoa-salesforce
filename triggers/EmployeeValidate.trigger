/**
 * Created by user on 5/6/2019.
 */

trigger EmployeeValidate on Employee__c (before insert) {
    for (Employee__c employee: Trigger.New) {
        if (employee.Salary__c < 100) employee.addError('Cannot create employee with salary greater than 100');
    }

}