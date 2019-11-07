({
    handleDiagnosisReceived : function(component, event, helper) {
        var possibleConditions = event.getParam("possibleConditions");

        component.set("v.possibleConditions", possibleConditions);
        possibleConditions = component.get("v.possibleConditions");
    }
})