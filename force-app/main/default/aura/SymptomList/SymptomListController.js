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
        var selectedSymptoms = component.get("v.selectedSymptoms");

        var action = component.get("c.callEdiagnose");

        var symptoms = ["s_8","s_21","s_102"];

        action.setParams({
            "symptoms":symptoms
        });

        action.setCallback(this, function(response) {
            var conditions = response.getReturnValue();

            console.log(`conditions: ${conditions}`);
        });

        $A.enqueueAction(action);
    },
})