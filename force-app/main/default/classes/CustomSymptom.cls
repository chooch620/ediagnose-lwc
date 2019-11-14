public with sharing class CustomSymptom {
    public String id { get;set; }
    public String choice_id { get;set; }

    public CustomSymptom(String infermedicaId) {
        if (infermedicaId.substring(0,1) != 's'){
            throw new InvalidInfermedicaIdException('InfermedicaId provided does not start with an s');
        }
        this.id = infermedicaId;
        this.choice_id = 'present';
    }
}