public with sharing class eDiagnoseCaller {
    public eDiagnoseCaller() {
        List<String> symptoms = new List<String> {'s_102', 's_21'};

        System.debug('Conditions: ' + eDiagnoseRequester.getConditions(25, 'male', symptoms));
        
    }
}
