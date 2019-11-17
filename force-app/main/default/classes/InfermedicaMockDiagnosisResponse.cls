@isTest
public  class InfermedicaMockDiagnosisResponse implements HttpCalloutMock {
    public HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        res.setStatusCode(200);
        
        // Mimic a diagnosis with only Fever being provided by the patient.
        String mockBody = '{\"question\":{\"type\":\"group_single\",\"text\":\"What is your body temperature?\","items":[{\"id\":\"s_99\",\"name\":\"Between 98.6 and 100.4 °F (37 and 38 °C)\",\"choices\":[{\"id\":\"present\",\"label\":\"Yes\"},{\"id\":\"absent\",\"label\":\"No\"},{\"id\":\"unknown\",\"label\":\"Dont know\"}]}],"extras":{}},"conditions":[{"id":"c_87","name":"Common cold","common_name":"Common cold","probability":0.0589}],"extras":{}}';
        res.setBody(mockBody);

        return res;
    }
}
    
