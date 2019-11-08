/**
 * @File Name          : InfermedicaRequester.cls
 * @Description        : 
 * @Author             : Matthew Ruiz
 * @Group              : 
 * @Last Modified By   : Matthew Ruiz
 * @Last Modified On   : 11/8/2019, 12:13:41 AM
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    11/7/2019   Matthew Ruiz     Initial Version
**/
public with sharing class InfermedicaRequester {
    @AuraEnabled
    public static List<Object> getPossibleConditions(Integer age, String sex, List<CustomSymptom> symptoms){
        List<Object> possibleConditions = new List<CustomCondition>();

        // Infermedica API requires that sex must be 'male' or 'female'
        String querySex = (sex == 'other') ? 'female' : sex;        
        // Infermedica API requires that age must be a positive integer between 0 and 130
        Integer queryAge = (0 < age && age < 130) ? age : 20;

        // Create the request
        Http http = new Http();
        HttpRequest request = buildInfermedicaDiagnosisRequest(queryAge, querySex, symptoms);

        HttpResponse response = http.send(request);
        
        return EDiagnosisResponseHandlerController.handleDiagnosisResponse(response);
        
        // return possibleConditions;
    }

    private static HttpRequest buildInfermedicaDiagnosisRequest(Integer age, String sex, List<CustomSymptom> symptoms) {
        HttpRequest request = new HttpRequest();
        
        // Set the endpoint
        request.setEndpoint('callout:InfermedicaAppKey/diagnosis');
        // Set HTTP Request Type
        request.setMethod('POST');

        // Set additional headers
        request.setHeader('App-Id', '{!$Credential.UserName}');
        request.setHeader('App-Key', '{!$Credential.Password}');
        request.setHeader('Content-Type', 'application/json');

        Map<String, Object> body = new Map<String, Object>();

        body.put('evidence', symptoms);
        body.put('age', age);
        body.put('sex', sex);

        String serializedBody = JSON.serialize(body);
        
        String bodyString = 'INFERMEDICA_READY body: ' + serializedBody;
        DebugWrappers.info(bodyString);

        request.setBody(serializedBody);

        return request;
    }

    public static void getAllSymptoms(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();

        // Set the endpoint
        request.setEndpoint('callout:InfermedicaAppKey/symptoms');
        // Set HTTP Request Type
        request.setMethod('GET');

        // Set additional headers
        request.setHeader('App-Id', '{!$Credential.UserName}');
        request.setHeader('App-Key', '{!$Credential.Password}');
        request.setHeader('Content-Type', 'application/json');

        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            handleResponse(response, 'symptoms');
        }
    }


    /**
        Handle a successful HttpResponse.
        Parse the JSON returned into a Map<String, String>
        containing key=Id, value=Name of symptoms and export to 
        a CSV file.
        String path specifies where to save the CSV file. 

        Author: https://github.com/garrettmaddox
     */
    private static void handleResponse(HttpResponse response, String path) {
                
        List<Object> api = (List<Object>)JSON.deserializeUntyped(response.getBody());

        List<Map<String, Object>> apiValues = new List<Map<String, Object>>();
        for (Object a : api) {
            apiValues.add(TypeConversions.convertToMapStringObject(a));
        }

        // Get the name and id of each symptom and put them in a map
        Map<String, String> symptomMap = extractIdAndName(apiValues);

        exportCSV(symptomMap, path);
    }

    /**
        Extract a Map<String, String>--where key is the Infermedica Id for a symptom
        and value is the name of the symptom--from a List<Map<String, Object>>

        Author: https://github.com/garrettmaddox
     */
    private static Map<String, String> extractIdAndName(List<Map<String, Object>> inputMaps) {
         
        Map<String, String> resultMap = new Map<String, String>();
        String id, name;

        for (Map<String, Object> mapVal : inputMaps) {
            id = (String)mapVal.get('id');
            name = (String)mapVal.get('name');
            resultMap.put(id, name);
        }        
        return resultMap;
    }

    /**
        Given a Map<String, String> where the key is an Infermedica Id
        for a symptom and the value is the name of the symptom,
        export a csv file with the header Id,Common Name

        Author: https://github.com/garrettmaddox
     */
    private static void exportCSV(Map<String, String> symptomMap, String path) {

        Set<String> symptomIds = symptomMap.keySet();
        String csv = 'Id,Common Name\n';

        // Remove any commas in the name
        for (String id : symptomIds) {
           if (symptomMap.get(Id).contains(',')) {

                String withoutComma = symptomMap.get(Id).replace(', ', '/');
                csv += id + ',' + withoutComma + '\n';

            } else {
                csv += id + ',' + symptomMap.get(id) + '\n';
            }  
        }

        ContentVersion file = new ContentVersion(
            title = path + '.csv',
            // VersionData is the body of the document (base64)
            // Blob is a collection of binary data stored as a single object. 
            VersionData = Blob.valueOf( csv ),
            pathOnClient = '/' + path + '.csv' // complete path of the document
        );    
        insert file;
    }
}