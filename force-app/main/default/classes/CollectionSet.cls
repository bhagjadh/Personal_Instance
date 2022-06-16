public class CollectionSet {
    
    public static void setDemo(){
        Set<String> emailSet = new Set<String>();
        emailSet.add('abc@gmail.com');
        emailSet.add('axyz@gmail.com');
        emailSet.add('pojshc@gmail.com');
        System.debug('Emailset=--->'+emailSet);
        
        Boolean isEmail = emailSet.contains('pojshc@gmail.com');
        Boolean isNotEmail = emailSet.contains('pojshc@gmailcom');
        System.debug('isEmail'+isEmail+'isNotEmail'+isNotEmail);
    }
    
    public static void mapDemo(){
        Map<String, String> nameMap = new Map<String, String>();
        nameMap.put('1', 'Amit');
        nameMap.put('2', 'Rohit');
        nameMap.put('3', 'Kiran');
        nameMap.put('4', 'Sanket');
        nameMap.put('5', 'Rahul');
        system.debug('NameMAp'+nameMap);
        System.debug('Contains Key-->'+nameMap.containsKey('1'));
        
        Set<String> keySet = nameMap.keySet();
        System.Debug('Keyset==>'+keySet);
        
        List<String> values = nameMap.values();
        System.debug('Values-->'+values);
        
        String name = nameMap.get('1');
        System.debug('name-->'+name);
        
        nameMap.put('1','SFDC Partner');
        System.debug('Updated nameMap-->'+nameMap);
        /*
         * Map<Id, List<Contact>> accContactMap = new Map<Id, List<Contact>>();
         * Values=> List<List<Contact>>;
         * Key => Set<Id>();
         * get => List<Contact> contactList = accContactMap.get('001);
         * Map<Id, Conatact> contactMap = new  Map<Id, Conatact>();
         * values => List<Contact>;
         * Map<Id, Map<String, String>> nestedMap = new Map<Id, Map<String, String>>();
         * values => List<Map<String, String>>>;
        */
        
        
    }

}