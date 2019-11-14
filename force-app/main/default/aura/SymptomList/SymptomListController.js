({
    handleSymptomSelected : function(component, event, helper) {
        var selectedSymptom = event.getParam("symptom");

        var selectedSymptoms = component.get("v.selectedSymptoms");
        if (!helper.symptomAlreadySelected(selectedSymptoms, selectedSymptom)) {
            selectedSymptoms.push(selectedSymptom);
        } else {
            helper.alreadySelectedToast();
        }
        component.set("v.selectedSymptoms", selectedSymptoms);
    },

    getConditions : function(component, event, helper) {
        let selectedSymptoms = component.get("v.selectedSymptoms");

        var action = component.get("c.getPossibleConditions");

        action.setParams({
            "symptoms":selectedSymptoms
        });

        action.setCallback(this, function(response) {
            var conditions = response.getReturnValue();
            console.log(`conditions: ${JSON.stringify(conditions)}`);

            var diagnosisReceivedEvent = $A.get("e.c:DiagnosisReceivedEvent");
            diagnosisReceivedEvent.setParams({
                "possibleConditions": conditions
            });
    
            diagnosisReceivedEvent.fire();


            console.log(`conditions: ${conditions}`);
        });

        $A.enqueueAction(action);
    },
})