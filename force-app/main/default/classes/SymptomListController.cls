public with sharing class SymptomListController {
    @AuraEnabled
    public static List<Symptom__c> getPossibleSymptoms(){
        return [SELECT Name FROM Symptom__c];
    }
}
