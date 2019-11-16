@isTest
public with sharing class InfermedicaRequesterTests {

    @isTest
    public static void testBuildRequestNoBody() {
        InfermedicaEndpoints mockEndpoint = InfermedicaEndpoints.DIAGNOSIS;
        String mockMethod = HttpMethods.postRequest;
        String mockAppId = '123';
        String mockAppKey = '456';
        String mockContentType = 'application/json';

        HttpRequest mockRequest = InfermedicaRequester.buildRequest(mockEndpoint, mockMethod, mockAppId, mockAppKey, mockContentType);

        System.assertEquals(mockRequest.getHeader('App-Id'), '123');
        // System.assertEquals(mockRequest.getHeader('App-Key'), '456');
        System.assertEquals(mockRequest.getHeader('Content-Type'), 'application/json');
        System.assertEquals(mockRequest.getBody(), '');

    }
}
