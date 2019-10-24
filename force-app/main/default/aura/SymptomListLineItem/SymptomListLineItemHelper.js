({
    getSymptoms : function() {
        List<Symptom__c> symptoms;

        var getSymptomsAction = component.get("c.getPossibleSymptoms");

        getSymptomsAction.setCallback(this, function(response) {
            symptoms = response.getReturnValue();
        });

        $A.enqueueAction(getSymptomsAction);
    },
})
