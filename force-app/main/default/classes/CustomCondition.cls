public with sharing class CustomCondition {
    public String name { get;set; }
    public String common_name { get;set; }
    public String id { get;set; }
    public Double probability { get;set; }
    public String description { get;set; }

    public CustomCondition() {
        name = '';
        common_name = '';
        id = '';
        probability = 0.0;
        description = '';
    }

    public CustomCondition(String name, String infermedicaId) {
        this.name = name;
        this.id = infermedicaId;

        common_name = '';
        probability = 0.0;
        description = '';
    }

    public CustomCondition(String name, String common_name, String infermedicaId) {
        this.name = name;
        this.common_name = common_name;
        this.id = infermedicaId;

        probability = 0.0;
        description = '';
    }

    public CustomCondition(String name, String common_name, String infermedicaId, Double probability) {
        this.name = name;
        this.common_name = common_name;
        this.id = infermedicaId;

        this.probability = probability;
        description = '';
    }
}