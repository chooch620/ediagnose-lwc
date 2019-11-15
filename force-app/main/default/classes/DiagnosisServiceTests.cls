@isTest
public with sharing class DiagnosisServiceTests {
    
    @isTest
    public static void testGetPossibleConditions() {

    }

    @isTest
    public static void testCreateSerializedBody() {
        Integer mockAge = 25;
        String mockSex = 'male';
        List<CustomSymptom> mockSymptoms = createMockCustomSymptoms();

        String expectedValue = '{"sex":"male","age":25,"evidence":[{"id":"s_123","choice_id":"present"},{"id":"s_456","choice_id":"present"}]}';
        String actualValue = DiagnosisService.createSerializedBody(mockAge, mockSex, mockSymptoms);

        System.assertEquals(expectedValue, actualValue);
    }

    private static List<CustomSymptom> createMockCustomSymptoms() {
        List<CustomSymptom> mockSymptoms = new List<CustomSymptom>();

        mockSymptoms.add(new CustomSymptom('s_123'));
        mockSymptoms.add(new CustomSymptom('s_456'));

        return mockSymptoms;

    }

    @isTest
    public static void testCreateMockCustomSymptoms() {
        List<CustomSymptom> mockSymptoms = createMockCustomSymptoms();

        System.assert(mockSymptoms.size() != 0);
        System.assert((mockSymptoms[0].id).equals('s_123'));
        System.assert((mockSymptoms[0].choice_id).equals('present'));
        System.assert((mockSymptoms[1].id).equals('s_456'));
        System.assert((mockSymptoms[1].choice_id).equals('present'));

    }
}
