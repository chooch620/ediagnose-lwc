public with sharing class DiagnosisService {
    @AuraEnabled
    public static List<Object> getPossibleConditions(Integer age, String sex, List<CustomSymptom> symptoms){

        // Infermedica API requires that sex must be 'male' or 'female'
        String querySex = (sex == 'other') ? 'female' : sex;        
        // Infermedica API requires that age must be a positive integer between 0 and 130
        Integer queryAge = (0 < age && age < 130) ? age : 20;


        String serializedBody = createSerializedBody(queryAge, querySex, symptoms);
        String appId = '{!$Credential.UserName}';
        String appKey = '{!$Credential.Password}';
        String contentType = 'application/json';
        String method = HttpMethods.getRequest;

        // Create the request
        Http http = new Http();
        HttpRequest request = InfermedicaRequester.buildRequest(InfermedicaEndpoints.DIAGNOSIS, HttpMethods.getRequest, appId, appKey, contentType, serializedBody);
        HttpResponse response = http.send(request);
        
        return EDiagnosisResponseHandlerController.handleDiagnosisResponse(response);
        
    }

    private static String createSerializedBody(Integer age, String sex, List<CustomSymptom> symptoms) {
        Map<String, Object> body = new Map<String, Object>();

        body.put('evidence', symptoms);
        body.put('age', age);
        body.put('sex', sex);

        String serializedBody = JSON.serialize(body);

        return serializedBody;
    }
}

