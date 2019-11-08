public with sharing class CustomSymptom {
    public String id { get;set; }
    public String choice_id { get;set; }

    public CustomSymptom(String infermedicaId) {
        this.id = infermedicaId;
        this.choice_id = 'present';
    }
}