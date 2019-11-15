public with sharing class SymptomRetriever {
    public static List<Symptom__c> getSymptomsWithSimilarName(String name) {
        String query = '%' + String.escapeSingleQuotes(name) + '%';
        System.debug('query: ' + query);
        if (Schema.sObjectType.Symptom__c.isAccessible()) {
            return [
                SELECT Id, Name, InfermedicaId__c
                FROM Symptom__c
                WHERE Name LIKE :query
                ORDER BY Name
                LIMIT 10
            ];
        } else {
            return new List<Symptom__c>();
        }
    }
}
