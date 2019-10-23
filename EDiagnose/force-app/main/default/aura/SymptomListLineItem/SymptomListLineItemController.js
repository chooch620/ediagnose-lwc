({
    doInit : function(component, event, helper) {
        var symptoms = helper.getSymptoms();

        $A.createComponent(
            "c:StatefulButton",
            {
                "name": "Ruiz",
                "infermedicaId" : "12345"
            },
            function(newSymptomListLineItem, status, errorMessage) {
                if (status === "SUCCESS" ){
                    var body = component.get("v.body");
                    body.push(newSymptomListLineItem);
                    component.set("v.body", body);
                }
            }
        );
    },
})
