public with sharing class SymptomListController {

    @AuraEnabled
    public static List<Map<String,Object>> callEdiagnose(List<Object> symptoms){
        System.debug('Symptoms: ' + symptoms);
        // List<CustomSymptom> cutomSymptoms = new List<CustomSymptom>();

        // for (Object symptom: symptoms) {
        //     Map<Object, Object> s = symptom;
            
        //     String name = (String)s.get('infermedicaId__c');
        //     cutomSymptoms.add(new CustomSymptom(name));
        // }
        System.debug('new symptoms: ' + symptoms);
        return eDiagnoseRequester.getConditions(21, 'male', new List<String>());
    }

    private static Map<String, Object> convertToMap(Object obj) {
        return (Map<String, Object>)obj;
    }
}