@isTest
public class CustomSymptomTests {
    @isTest
    public static void testCustomSymptomConstructor() {

        // Valid InfermedicaId 
        String mockValidInfermedicaId = 's_123';
        CustomSymptom mockValidCustomSymptom = new CustomSymptom(mockValidInfermedicaId);
        
        System.assert(mockValidCustomSymptom.Id != null);
        System.assertEquals(mockValidCustomSymptom.choice_id, 'present');

        // Invalid InfermedicaId
        String mockInvaludInfermedicaId = '123';
        Boolean invalidInfermedicaIdExceptionCaught = false;
        String expectedInvalidInfermedicaIdExceptionMessage = 'InfermedicaId provided does not start with an s';
        String actualInvalidInfermedicaIdExceptionMessage = '';

        try {
            CustomSymptom mockInvalidCustomSymptom = new CustomSymptom(mockInvaludInfermedicaId);
        } catch (InvalidInfermedicaIdException iie) {
            invalidInfermedicaIdExceptionCaught = true;
            actualInvalidInfermedicaIdExceptionMessage = iie.getMessage();
        }

        System.assert(invalidInfermedicaIdExceptionCaught);
        System.assertEquals(expectedInvalidInfermedicaIdExceptionMessage, actualInvalidInfermedicaIdExceptionMessage);
    }
}
