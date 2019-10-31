({
    doInit : function(component, event, helper) {
        var symptom = component.get("v.symptom");
        helper.createSymptomButton(component, symptom);

    },
})