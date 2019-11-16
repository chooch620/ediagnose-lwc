@isTest
public with sharing class SymptomListControllerTests {
    
    @isTest
    public static void testGetPossibleConditions() {

    }

    @isTest
    public static void testGetSymptoms() {

    }

    @isTest
    public static void testExtractSymptom() {
        // Test that a valid Symptom object was provided by client
        Object mockSymptomPositive = TestDataFactory.createCustomSymptomObjectWithValidInfermedicaId();
        CustomSymptom actualSymptomPositive = SymptomListController.extractSymptom(mockSymptomPositive);

        System.assertEquals(actualSymptomPositive.id, 's_123');
        System.assertEquals(actualSymptomPositive.choice_id, 'present');


        Object mockSymptomNegative = TestDataFactory.createCustomSymptomObjectWithoutInfermedicaId();
        Boolean infermedicaIdNotFoundExceptionCaught = false;
        try {
            CustomSymptom actualSymptomNegative = SymptomListController.extractSymptom(mockSymptomNegative);
        } catch (InfermedicaIdNotFoundException infe) {
            infermedicaIdNotFoundExceptionCaught = true;
        }

        System.assert(infermedicaIdNotFoundExceptionCaught);
    }
}
