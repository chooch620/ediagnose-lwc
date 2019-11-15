@isTest
public with sharing class SymptomRetrieverTests {
    @TestSetup
    static void makeData(){
        Symptom__c s = new Symptom__c(Name='MockSymptom1',InfermedicaId__c='s_123');
        insert s;
    }
    
    @isTest
    public static void testGetSymptomsWithSimilarName() {
        String mockName = 'mock';
        List<Symptom__c> mockSymptoms = SymptomRetriever.getSymptomsWithSimilarName(mockName);
        
        System.assert(mockSymptoms.size() != 0);

        String expectedName = 'MockSymptom1';
        String actualName = mockSymptoms[0].Name;
        System.assertEquals(expectedName, actualName);
    }
}
