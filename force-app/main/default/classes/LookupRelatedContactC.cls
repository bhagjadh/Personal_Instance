public class LookupRelatedContactC {
    
    @AuraEnabled
    public static List<Contact> getCon(List<String> accId) {
        return [SELECT Id, Name, Phone FROM Contact WHERE AccountId=:accId];
    }
}