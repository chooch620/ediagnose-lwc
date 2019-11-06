({
    init: function(component, event, helper) {
        helper.loadList(component);
    },

    handleClickSymptomName: function (component, event, helper) {
        const target = event.currentTarget;
        const symptomId = target.dataset.symptomId;
        const symptomName = target.dataset.symptomName;

        var symptomSelectedEvent = $A.get("e.c:SymptomSelectedEvent");
        symptomSelectedEvent.setParams({
            "symptom": {"Id":symptomId,"Name":symptomName}
        });

        symptomSelectedEvent.fire();
    },

    handleNameFilterChange: function (component, event, helper) {
        helper.loadList(component);
    },
})