/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 06-10-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class HandleCustomException extends Exception {
    public static void LogException(Exception e, String className,String methodName)
    {
        LogException(e,className,methodName,'');
    }
    
    // Log Exception in CustomException object. 
    // relatedToId : Case/object for which this error in logged.
    public static void LogException(Exception e,String className,String methodName,string relatedToId)
    {
        try
        {
		    String stackTrace = e.getStackTraceString().substringBefore('\n');
		// String className = stackTrace.substringAfter('.').substringBefore('.');	
            	//String methodName = stackTrace.substringBefore(':').substringAfter(className).substringAfter('.');
                
            	//Governer Limit of executingQuery 
                String QueryLimit = '1. SOQL Queries used / SOQL Queries allowed: ' + Limits.getQueries() + '/' + Limits.getLimitQueries();
                String DMLimit = '2. Number of records queried so far /  Number allowed: ' + Limits.getDmlRows() + '/' + Limits.getLimitDmlRows();
                String DMLStat = '3. Number of DML statements used so far / Number allowed: ' +  Limits.getDmlStatements() + '/' + Limits.getLimitDmlStatements();   
                String CPUT = '4. Amount of CPU time (in ms) used so far / CPU usage time (in ms) allowed: ' + Limits.getCpuTime() + '/' + Limits.getLimitCpuTime();
              
            	//Log information in object
                Exception_Log__c exc = new Exception_Log__c();
            	exc.Related_To_Number__c=relatedToId;
                exc.Govt_Limit_in_Executing_Code__c = String.format('{0}\n{1}\n{2}\n{3}',new List<string>{QueryLimit, DMLimit,DMLStat,CPUT});
                exc.Message__c = e.getMessage();
                exc.Exception_Type__c = e.getTypeName();
                exc.Line_Number__c = e.getLineNumber();
                exc.StackTrace__c = e.getStackTraceString();
                exc.Source_Function__c=methodName;
                exc.Source__c=className;

                if(Exception_Log__c.sObjectType.getDescribe().isCreateable()){
                    system.debug('Inside if');
                    Database.SaveResult saveLog = Database.insert(exc,false);
                    system.debug('Save log'+saveLog);
                }
                        
        } 
        finally{
        }            
    } 
}
