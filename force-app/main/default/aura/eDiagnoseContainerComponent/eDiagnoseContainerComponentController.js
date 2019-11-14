({
    handleDiagnosisReceived : function(component, event, helper) {
        var possibleConditions = event.getParam("possibleConditions");

        console.log(`possibleConditions: ${JSON.stringify(possibleConditions)}`);
        component.set("v.possibleConditions", possibleConditions);
    }
})