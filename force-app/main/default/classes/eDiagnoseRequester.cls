public class eDiagnoseRequester {
	@AuraEnabled
    public static List<Map<String,Object>> getConditions(Integer age, String sex, List<String> symptoms) {

        List<Map<String,Object>> possibleConditions = new List<Map<String,Object>>();

        // API requires that sex must be 'male' or 'female'
        String querySex = (sex == 'other') ? 'female' : sex;        
        // API requires that age must be a positive integer between 0 and 130
        Integer queryAge = (0 < age && age < 130) ? age : 20;

        // Create the request
        Http http = new Http();
        HttpRequest request = new HttpRequest();

        // Set the endpoint
        request.setEndpoint('callout:InfermedicaAppKey/diagnosis');
        // Set HTTP Request Type
        request.setMethod('POST');

        // Set additional headers
        request.setHeader('App-Id', '{!$Credential.UserName}');
        request.setHeader('App-Key', '{!$Credential.Password}');
        request.setHeader('Content-Type', 'application/json');

        // Set the body
        Map<String, Object> body = new Map<String, Object>();
        List<Map<String, Object>> evidence = new List<Map<String, Object>>();

        for (String symptomId : symptoms) {
            Map<String, Object> symptomObj  = new Map<String, Object>();
            symptomObj.put('choice_id', 'present');
            symptomObj.put('id', symptomId);
            evidence.add(symptomObj);
        }

        body.put('evidence', evidence);
        body.put('age', queryAge);
        body.put('sex', querySex);

        System.debug('body: ' + body);
		String bodyJSON = JSON.serialize(body);
        System.debug('bodyJSON: ' + bodyJSON);

        request.setBody(bodyJSON);
        System.debug('request: ' + request);

        HttpResponse response = http.send(request);
        System.debug('response: ' + response);

        if (response.getStatusCode() == 200) {
            System.debug('responseBody: ' + response.getBody());

            Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
        	System.debug('results: ' + results);
            List<Object> conditions = (List<Object>)results.get('conditions');
            System.debug('conditions: ' + conditions);

            for (Object cond : conditions) {
                Map<String, Object> conditionInfo = new Map<String,Object>();
                Map<String, Object> condMap = (Map<String, Object>)cond;
                conditionInfo.put('Name', (String)condMap.get('name'));
                conditionInfo.put('Probability', (Double)condMap.get('probability'));

				System.debug('conditionInfo: ' + conditionInfo);
                possibleConditions.add(conditionInfo);
            }
        }

        System.debug('possibleConditions: ' + possibleConditions);
        return possibleConditions;
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
     */
    private static void handleResponse(HttpResponse response, String path) {
                
        List<Object> api = (List<Object>)JSON.deserializeUntyped(response.getBody());

        List<Map<String, Object>> apiValues = new List<Map<String, Object>>();
        for (Object a : api) {
            apiValues.add(convertToMap(a));
        }

        // Get the name and id of each symptom and put them in a map
        Map<String, String> symptomMap = extractIdAndName(apiValues);

        exportCSV(symptomMap, path);
    }

    /**
        Extract a Map<String, String>--where key is the Infermedica Id for a symptom
        and value is the name of the symptom--from a List<Map<String, Object>>
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

    /**
        Cast an Object to Map<String, Object>
     */
    private static Map<String, Object> convertToMap(Object obj) {
        return (Map<String, Object>)obj;
    }
}