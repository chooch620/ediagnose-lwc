/**
 * @File Name          : DebugWrappers.cls
 * @Description        : Debug methods broken up into level. 
 * @Author             : Matthew Ruiz
 * @Group              : 
 * @Last Modified By   : Matthew Ruiz
 * @Last Modified On   : 11/7/2019, 10:33:30 PM
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    11/7/2019   Matthew Ruiz     Initial Version
**/
public with sharing class DebugWrappers {

    public static void info(String message) {
        System.LoggingLevel info = LoggingLevel.INFO;
        System.debug(info, message);
    }
}