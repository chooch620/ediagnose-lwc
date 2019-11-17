public with sharing class InfermedicaResponseHandlerController {
    public static List<InfermedicaCondition> handleDiagnosisResponse(HttpResponse response) {
        System.debug('resp body: ' + response.getBody());
        Integer statusCode = response.getStatusCode();

        if (statusCode == 200) {
            InfermedicaDiagnosisResponse diagnosisResponse = (InfermedicaDiagnosisResponse)JSON.deserialize(response.getBody(), InfermedicaDiagnosisResponse.class);

            upsertConditions(diagnosisResponse.conditions);
            return diagnosisResponse.conditions;
        }

        throw new AuraHandledException(response.toString()); 
    }
    
    private static void upsertConditions(List<InfermedicaCondition> conditions) {
        List<Condition__c> conditionsToUpsert = new List<Condition__c>();
        
        for (InfermedicaCondition condition: conditions) {
            conditionsToUpsert.add(condition.getCondition());   
        }

        List<Database.UpsertResult> srs = Database.upsert(conditionsToUpsert, false);
    }

    public with sharing class InfermedicaDiagnosisResponse {
        public InfermedicaQuestion question { get;set; }
        public List<InfermedicaCondition> conditions { get;set; }
        public String should_stop { get;set; }
        public InfermedicaExtras extras { get;set; }
    }

    @TestVisible private with sharing class InfermedicaQuestion {
        public String type { get;set; }
        public String text { get;set; }
        public List<InfermedicaItem> items { get;set; }
        public InfermedicaExtras extras { get;set; }
    }

    @TestVisible private with sharing class InfermedicaItem {
        public String id { get;set; }
        public String name { get;set; }
        public List<InfermedicaChoice> choices { get;set; }
    }

    @TestVisible private with sharing class InfermedicaChoice {
        public String id { get;set; }
        public String label { get;set; }
    }

    @TestVisible private with sharing class InfermedicaExtras {} 

    @TestVisible private with sharing class InfermedicaCondition {
        public String id { get;set; }
        public String name { get;set; }
        public String common_name { get;set; }
        public Decimal probability { get;set; }
        public Condition__c getCondition() {
            Condition__c c = new Condition__c();
            c.InfermedicaId__c = id;
            c.Name = name;
            c.Probability__c = probability;
            c.CommonName__c = common_name;

            return c;
        }
    }
}