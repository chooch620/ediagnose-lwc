public with sharing class TypeConversions {
    
    /**
    * @description Given an obj, attempt to convert it to a Map<String, ANY>
    * @author Matthew Ruiz | 11/7/2019 
    * @param obj 
    * @return Map<String, Object> 
    **/
    public static Map<String, Object> convertToMapStringObject(Object obj) {
        try {
            return (Map<String, Object>)obj;
        } catch (TypeException te) {
            throw new InvalidTypeConversionException(te.getMessage());
        }
    }

    /**
    * @description Given an obj, attempt to convert it to a Map<ANY, ANY>
    * @author Matthew Ruiz | 11/7/2019 
    * @param obj 
    * @return Map<Object, Object> 
    **/
    public static Map<Object, Object> convertToMapObjectObject(Object obj) {
        try {
            return (Map<Object, Object>)obj;
        } catch (TypeException te) {
            throw new InvalidTypeConversionException(te.getMessage());
        }
    }

    private class InvalidTypeConversionException extends Exception {}
}