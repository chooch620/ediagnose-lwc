@isTest
public class InfermedicaResponseHandlerTests {
    @isTest
    public static void testHandleDiagnosisResponse() {
        HttpResponse mockResponse = new HttpResponse();
        mockResponse.setStatusCode(200);
        
        // Mimic a diagnosis with only Fever being provided by the patient.
        String mockBody = '{\"question\":{\"type\":\"group_single\",\"text\":\"What is your body temperature?\","items":[{\"id\":\"s_99\",\"name\":\"Between 98.6 and 100.4 °F (37 and 38 °C)\",\"choices\":[{\"id\":\"present\",\"label\":\"Yes\"},{\"id\":\"absent\",\"label\":\"No\"},{\"id\":\"unknown\",\"label\":\"Dont know\"}]}],"extras":{}},"conditions":[{"id":"c_87","name":"Common cold","common_name":"Common cold","probability":0.0589}],"extras":{}}';
        mockResponse.setBody(mockBody);

        List<InfermedicaResponseHandlerController.InfermedicaCondition> conditions = InfermedicaResponseHandlerController.handleDiagnosisResponse(mockResponse);
        
        // Test properties
        String expectedId = 'c_87';
        String actualId = conditions[0].id;
        System.assertEquals(expectedId,actualId);

        String expectedName = 'Common cold';
        String actualName = conditions[0].name;
        System.assertEquals(expectedName, actualName);

        String expectedCommonName = 'Common cold';
        String actualCommonName = conditions[0].common_name;
        System.assertEquals(expectedCommonName, actualCommonName);

        Double expectedProbability = 0.0589;
        Double actualprobability = conditions[0].probability;
        System.assertEquals(expectedProbability, actualprobability);

        // test getCondition()
        Condition__c c = conditions[0].getCondition();
        System.assertEquals(expectedId,c.InfermedicaId__c);
        System.assertEquals(expectedName,c.Name);
        System.assertEquals(expectedProbability,c.Probability__c);
        System.assertEquals(expectedCommonName,c.CommonName__c);
    }
}