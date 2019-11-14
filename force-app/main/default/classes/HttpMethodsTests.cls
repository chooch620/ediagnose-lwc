@isTest
public class HttpMethodsTests {
    @isTest
    public static void testGetRequest() {
        System.assertEquals(HttpMethods.getRequest, 'GET');
    }

    @isTest
    public static void testPostRequest() {
        System.assertEquals(HttpMethods.postRequest, 'POST');
    }
    
    @isTest
    public static void testPutRequest() {
        System.assertEquals(HttpMethods.putRequest, 'PUT');
    }

    @isTest
    public static void testPatchRequest() {
        System.assertEquals(HttpMethods.patchRequest, 'PATCH');
    }

    @isTest
    public static void testDeleteRequest() {
        System.assertEquals(HttpMethods.deleteRequest, 'DELETE');
    }
}
