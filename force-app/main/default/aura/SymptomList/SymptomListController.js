({
    doInit : function(component, event, helper) {
        var symptomsAction = component.get("c.getPossibleSymptoms");

        symptomsAction.setCallback(this, function(response) {
            var state = response.getState();

            if (state === "SUCCESS") {
                var possibleSymptoms = response.getReturnValue();
                component.set("v.possibleSymptoms", possibleSymptoms);
            } else {
                console.error(`Error: ${response.getError()}`);
            }
        });

        $A.enqueueAction(symptomsAction);
    },
})