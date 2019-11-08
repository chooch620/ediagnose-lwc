/**
 * @File Name          : SymptomListController.cls
 * @Description        : 
 * @Author             : Matthew Ruiz
 * @Group              : 
 * @Last Modified By   : Matthew Ruiz
 * @Last Modified On   : 11/8/2019, 12:10:51 AM
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    11/7/2019   Matthew Ruiz     Initial Version
**/

public with sharing class SymptomListController {

    private static final String SYMPTOM_WITHOUT_INFERMEDICA_ID = 'Symptom was passed without an InfermedicaId: ';

    @AuraEnabled
    public static List<Object> callEdiagnose(List<Object> symptoms){
        // Will be used as the evidence value in the diagnosis Infermedica request
        List<CustomSymptom> customSymptoms = new List<CustomSymptom>();
        
        for (Object symptom: symptoms) {
            try {
                customSymptoms.add(extractSymptom(symptom));
            } catch (InfermedicaIdNotFoundException infe) {
                throw new AuraHandledException(SYMPTOM_WITHOUT_INFERMEDICA_ID + symptom);
            }
        }

        String symptomString = 'INFERMEDICA_READY Symptoms: ' + customSymptoms;
        DebugWrappers.info(symptomString);

        List<Object> o =  InfermedicaRequester.getPossibleConditions(21, 'male', customSymptoms);
        System.debug('o: ' + o);
        return o;
    }

    /**
    * @description An object is sent from the client-side and we only need the Infermedica Id. Extract it.
    * @author Matthew Ruiz | 11/7/2019 
    * @param symptom Object sent by client-side. {Id,Name,InfermedicaId__c}
    * @return CustomSymptom 
    **/
    private static CustomSymptom extractSymptom(Object symptom) {
        Map<Object, Object> symptomMap = TypeConversions.convertToMapObjectObject(symptom);

        for (Object key: symptomMap.keySet()) {

            if (!((String)key).equals('InfermedicaId__c')) { continue; }
            return new CustomSymptom((String)symptomMap.get(key));
        }
        throw new InfermedicaIdNotFoundException();
    }

    public class InfermedicaIdNotFoundException extends Exception {}
}