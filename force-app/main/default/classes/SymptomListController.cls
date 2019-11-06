public with sharing class SymptomListController {
    @AuraEnabled
    public static List<Symptom__c> getPossibleSymptoms(){
        return [SELECT Name FROM Symptom__c LIMIT 10];
    }

    @AuraEnabled
    public static List<Map<String,Object>> callEdiagnose(List<String> symptoms){
        return eDiagnoseRequester.getConditions(21, 'male', symptoms);
    }
}