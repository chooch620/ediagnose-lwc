@isTest
public class CustomSymptomTests {
    @isTest
    public static void testCustomSymptomConstructor() {

        String mockInfermedicaId = 's_123';
        CustomSymptom mockCustomSymptom = new CustomSymptom(mockInfermedicaId);
        
        System.assert(mockCustomSymptom.Id != null);
        System.assertEquals(mockCustomSymptom.choice_id, 'present');
    }
}
