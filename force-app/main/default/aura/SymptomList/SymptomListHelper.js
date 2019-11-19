({
    extractInfermedicaIds: function(component) {
        let symptoms = component.get("v.selectedSymptoms")
        return symptoms.map(symptom => symptom.InfermedicaId__c);
    },
})