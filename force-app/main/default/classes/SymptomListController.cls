/**
 * @File Name          : SymptomListController.cls
 * @Description        : 
 * @Author             : Matthew Ruiz
 * @Group              : 
 * @Last Modified By   : Matthew Ruiz
 * @Last Modified On   : 11/8/2019, 4:21:48 PM
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    11/7/2019   Matthew Ruiz     Initial Version
**/

public with sharing class SymptomListController {

    private static final String SYMPTOM_WITHOUT_INFERMEDICA_ID = 'Symptom was passed without an InfermedicaId: ';

    @AuraEnabled
    public static List<Object> getPossibleConditions(List<Object> symptoms){
        // Will be used as the evidence value in the diagnosis Infermedica request
        List<CustomSymptom> customSymptoms = getSympmtoms(symptoms);

        String symptomString = 'INFERMEDICA_READY Symptoms: ' + customSymptoms;
        DebugWrappers.info(symptomString);

        return DiagnosisService.getPossibleConditions(21, 'male', customSymptoms);
    }


    /**
    * @description Extract the fields needed for the Diagnosis request.
    * @author Matthew Ruiz | 11/14/2019 
    * @param symptoms List of Objects, which mimicthe Symptom__c sObject
    * @return List<CustomSymptom> 
    **/
    private static List<CustomSymptom> getSympmtoms(List<Object> symptoms) {
        List<CustomSymptom> customSymptoms = new List<CustomSymptom>();

        for (Object symptom: symptoms) {
            try {
                customSymptoms.add(extractSymptom(symptom));
            } catch (InfermedicaIdNotFoundException infe) {
                throw new AuraHandledException(SYMPTOM_WITHOUT_INFERMEDICA_ID + symptom);
            }
        }

        return customSymptoms;
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