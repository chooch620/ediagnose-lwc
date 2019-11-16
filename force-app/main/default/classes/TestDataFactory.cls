@isTest
public with sharing class TestDataFactory {
    public static Object createCustomSymptomObjectWithValidInfermedicaId() {
        Map<Object,Object> mockSymptomMap = new Map<Object, Object>();
        
        mockSymptomMap.put('Id', '123');
        mockSymptomMap.put('InfermedicaId__c', 's_123');
        mockSymptomMap.put('Name', 'MockName');

        return (Object)mockSymptomMap;
    }

    public static Object createCustomSymptomObjectWithoutInfermedicaId() {
        Map<Object,Object> mockSymptomMap = new Map<Object, Object>();
        
        mockSymptomMap.put('Id', '123');
        mockSymptomMap.put('Name', 'MockName');

        return (Object)mockSymptomMap;
    }
    
    public static Object createCustomSymptomObjectWithInvalidInfermedicaId() {
        Map<Object,Object> mockSymptomMap = new Map<Object, Object>();
        
        mockSymptomMap.put('Id', '123');
        mockSymptomMap.put('InfermedicaId__c', '123');
        mockSymptomMap.put('Name', 'MockName');

        return (Object)mockSymptomMap;
    }

}
