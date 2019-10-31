({
    createSymptomButton : function(component, symptom) {
        var name = symptom["Name"];

        $A.createComponent(
            "c:pill",
            {
                "name": name
            },
            function(symptomButton, status, errorMessage) {
                if (status === "SUCCESS" ){
                    var body = component.get("v.body");
                    body.push(symptomButton);
                    component.set("v.body", body);
                } else {
                    return -1;
                }
            }


            // "c:statefulButton",
            // {
            //     "name": name,
            // },
            // function(symptomButton, status, errorMessage) {
            //     if (status === "SUCCESS" ){
            //         var body = component.get("v.body");
            //         body.push(symptomButton);
            //         component.set("v.body", body);
            //     } else {
            //         return -1;
            //     }
            // }
        );
    },
})