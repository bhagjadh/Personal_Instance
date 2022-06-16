public with sharing class CampingListController {
    @AuraEnabled
    public static List<Camping_Item__c> getItems() {
        // Perform isAccessible() checking first, then
        return [SELECT Id, Name, Packed__c, Price__c, Quantity__c, CreatedDate FROM Camping_Item__c];
    }
    @AuraEnabled
    public static Camping_Item__c saveItem(Camping_Item__c campingItems) {
        // Perform isUpdateable() checking first, then
        upsert campingItems;
        return campingItems;
    }
}