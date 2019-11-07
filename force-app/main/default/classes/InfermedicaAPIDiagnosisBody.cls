public with sharing class InfermedicaAPIDiagnosisBody {
    public String id { get;set; }
    public String choice_id { get;set; }
    public Integer age { get;set; }
    public String sex { get;set; }
    public List<InfermedicaAPIDiagnosisBodyEvidence> evidence { get;set; }

    public InfermedicaAPIDiagnosisBody() {
        id = '';
        choice_id = '';
        age = 0;
        sex = '';
        evidence = new List<InfermedicaAPIDiagnosisBodyEvidence>();
    }
}
