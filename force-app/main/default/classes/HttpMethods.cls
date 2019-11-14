public class HttpMethods {

    public static String getRequest { 
        get {
            if (getRequest == null) { getRequest = 'GET'; }
            return getRequest;
        } 
        private set;
    }
    public static String postRequest { 
        get {
            if (postRequest == null) { postRequest = 'POST'; }
            return postRequest;
        } 
        private set;
    }

    public static String putRequest { 
        get {
            if (putRequest == null) { putRequest = 'PUT'; }
            return putRequest;
        } 
        private set;
    }

    public static String patchRequest { 
        get {
            if (patchRequest == null) { patchRequest = 'PATCH'; }
            return patchRequest;
        } 
        private set;
    }

    public static String deleteRequest { 
        get {
            if (deleteRequest == null) { deleteRequest = 'DELETE'; }
            return deleteRequest;
        } 
        private set;
    }


}
