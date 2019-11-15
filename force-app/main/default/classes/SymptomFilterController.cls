public with sharing class SymptomFilterController {

    @AuraEnabled(cacheable=true)
    public static List<Symptom__c> allSymptomsWithSimilarName(String name){
        return SymptomRetriever.getSymptomsWithSimilarName(name);
    }
}