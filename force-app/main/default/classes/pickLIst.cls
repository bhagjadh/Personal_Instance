public class pickLIst {          
    @AuraEnabled
    public static List<String> pickList(String obj, String str) {
         List<String> regList = new List<String>(); 
            Schema.DescribeFieldResult plistvalues = Schema.getGlobalDescribe().get(obj).getDescribe().fields.getMap().get(str).getDescribe();
            for(PicklistEntry ent:plistvalues.getpicklistvalues())     {
                regList.add(ent.getLabel());
            }
             return regList;
  
  }
}