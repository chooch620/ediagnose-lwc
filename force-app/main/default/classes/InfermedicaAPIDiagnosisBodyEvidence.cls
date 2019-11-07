public with sharing class InfermedicaAPIDiagnosisBodyEvidence {
    public String choice_id { get;set; }
    public String id { get;set; }

    public InfermedicaAPIDiagnosisBodyEvidence(String choice_id, String id) {
        this.choice_id = choice_id;
        this.id = id;
    }
}
