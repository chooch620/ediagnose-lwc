({
    handleDiagnosisReceived : function(component, event, helper) {
        var possibleConditions = event.getParam("possibleConditions");

        console.log(`possibleConditions: ${JSON.stringify(possibleConditions)}`);
        component.set("v.possibleConditions", possibleConditions);
    },

    handleSymptomSelected : function(component, event, helper) {
        var selectedSymptom = event.getParam("symptom");

        var selectedSymptoms = component.get("v.selectedSymptoms");
        if (!helper.symptomAlreadySelected(selectedSymptoms, selectedSymptom)) {
            selectedSymptoms.push(selectedSymptom);
        } else {
            helper.alreadySelectedToast();
        }
        component.set("v.selectedSymptoms", selectedSymptoms);
    }
})