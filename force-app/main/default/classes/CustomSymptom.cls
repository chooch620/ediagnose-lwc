public with sharing class CustomSymptom {
    public String choice_id { get;set; }
    public String infermedicaId { get;set; }

    public CustomSymptom(String infermedicaId) {
        this.choice_id = 'present';
        this.infermedicaId = infermedicaId;
    }
}
