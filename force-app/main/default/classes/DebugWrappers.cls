public with sharing class DebugWrappers {

    public static void info(String message) {
        System.LoggingLevel info = LoggingLevel.INFO;
        System.debug(info, message);
    }
}