({
    init: function(component, event, helper) {
        helper.loadList(component);
    },

    handleClickSymptomName: function (component, event, helper) {
        const target = event.currentTarget;

        const symptom = {
            "Id": target.dataset.id,
            "Name": target.dataset.name,
            "InfermedicaId__c": target.dataset.infermedicaId
        }

        var symptomSelectedEvent = $A.get("e.c:SymptomSelectedEvent");
        symptomSelectedEvent.setParams({
            "symptom": symptom
        });

        symptomSelectedEvent.fire();
    },

    handleNameFilterChange: function (component, event, helper) {
        helper.loadList(component);
    },
})