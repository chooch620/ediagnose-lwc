({
    symptomAlreadySelected : function(selectedSymptoms, selectedSymptom) {
        var found = false;
        for(var i = 0; i < selectedSymptoms.length; i++) {
            if (selectedSymptoms[i].Name == selectedSymptom.Name) {
                found = true;
                break;
            }
        }
        return found;
    },

    alreadySelectedToast: function() {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Already Selected",
            "message": "This symptom has already been selected."
        });
        toastEvent.fire();
    },

    extractInfermedicaIds: function(component) {
        let symptoms = component.get("v.selectedSymptoms")
        return symptoms.map(symptom => symptom.InfermedicaId__c);
    },
})