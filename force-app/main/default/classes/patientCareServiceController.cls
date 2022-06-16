/**
 * @description       : 
 * @author            : Bhagyashri Jadhav
 * @group             : 
 * @last modified on  : 06-16-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class patientCareServiceController {

    /**
    * @description 
    * @author Bhagyashri Jadhav | 06-08-2022 
    * @return Map<String, List<String>> 
    **/
    @AuraEnabled
    public static Map<String,List<String>> getPickListValuesIntoList(){
        //Map<String, Patient_Form_Picklists__c> mcs = Patient_Form_Picklists__c.getAll();

        List<Patient_Form_Picklists__c> picklistValues = Patient_Form_Picklists__c.getAll().values();

        Map<String,List<String>> picklistFieldsWithValues = new Map<String,List<String>>();

        for(Patient_Form_Picklists__c m: picklistValues){

            System.debug('Custom Setting Values : ' +m);

 

            System.debug('Object Name : ' +m.Object_Type__c);

            Schema.SObjectType convertToObj = Schema.getGlobalDescribe().get(m.Object_Type__c);

            System.debug('Object type : ' +convertToObj);

 

            Schema.DescribeSObjectResult res = convertToObj.getDescribe();

 

            System.debug('Picklist Field Name : ' +m.Picklist_Field_Name__c);

            Schema.DescribeFieldResult fieldResult = res.fields.getMap().get(m.Picklist_Field_Name__c).getDescribe();

            System.debug('Picklist Field result : ' +fieldResult);

            List<String> pickListValuesList = new List<String>();

            List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
           // System.debug('PicklistEntry Field result : ' +JSON.Strignify(ple));
            System.debug('PicklistEntry Field result : ' +ple);

            for( Schema.PicklistEntry pickListVal : ple){

                pickListValuesList.add(pickListVal.getLabel());

                picklistFieldsWithValues.put(fieldResult.getName().replace('__c',''),pickListValuesList);

            }

        }

        System.debug('Picklis Fields with Values : ' +picklistFieldsWithValues);

        return picklistFieldsWithValues;

    }

    /**
    * @description 
    * @author ChangeMeIn@UserSettingsUnder.SFDoc | 06-08-2022 
    * @param patientWrap 
    * @return patientWrapperClass 
    **/
    @AuraEnabled
    public static patientWrapperClass getPatientInfo(patientWrapperClass patientWrap) {
       // system.debug('In GetatientInfo'+JSON.serialize(patientWrap));
        system.debug('In GetatientInfo'+patientWrap);
        try{
            Patient__c newPatient = new Patient__c();
            if(patientWrap.patientsInfo!=null){
                system.debug('In patientInfo');
                if(Patient__c.sObjectType.getDescribe().isCreateable()){
                    system.debug('In patientInfo before creating ');
                    newPatient = patientWrap.patientsInfo;
                    system.debug('newPatient-->'+newPatient);
                    Database.SaveResult savePatientRecord = Database.insert(newPatient, true);
                    system.debug('newPatient-->'+newPatient);
                    system.debug('patientWrap.patientsInfo-->'+patientWrap.patientsInfo);
                    if(newPatient.Id!=null){
                        system.debug('In patientInfo after creating ');
                        Patient_Care_Service__c newTherapyService = new Patient_Care_Service__c();
                        Patient_Care_Service__c newNursingService = new Patient_Care_Service__c();
                        List<Patient_Care_Service__c> patientServiceList = new List<Patient_Care_Service__c>();

                        if(patientWrap.therapypatientCareServices != null && patientWrap.therapypatientCareServices.Therapy_Service__c == true){
                            Id therapyRecordTypeId = [select Id,DeveloperName from RecordType where DeveloperName = 'Therapy_Service' AND sObjectType = 'Patient_Care_Service__c' limit 1].Id;
                            
                            newTherapyService = patientWrap.therapypatientCareServices;
                            newTherapyService.RecordTypeId = therapyRecordTypeId; // assigning Patient Care service record type as a Therapy Service
                            newTherapyService.Patient__c = newPatient.ID;
                            system.debug('newTherapyService'+newTherapyService);
                            patientServiceList.add(newTherapyService);
                        }

                        if(patientWrap.nursingpatientCareServices != null && patientWrap.nursingpatientCareServices.Nursing_Service__c == true){
                            Id nursingRecordTypeId = [select Id,DeveloperName from RecordType where DeveloperName = 'Nursing_Service' AND sObjectType = 'Patient_Care_Service__c' limit 1].Id;
                            
                            newNursingService = patientWrap.nursingpatientCareServices;
                            newNursingService.RecordTypeId = nursingRecordTypeId; // assigning Patient Care service record type as a Therapy Service
                            newNursingService.Patient__c = newPatient.ID;
                            system.debug('newNursingService'+newNursingService);
                            patientServiceList.add(newNursingService);
                        }
                        if(patientServiceList != null){
                            if(Patient__c.sObjectType.getDescribe().isCreateable()){
                                Database.SaveResult[] savePSList = Database.insert(patientServiceList, true);
                            }else{
                                system.debug('tes Block');
                                throw new AuraHandledException('You do not have access to add Patient Services');
                            }    
                        }
                    }
                }else{
                    system.debug('test1 Block');
                    throw new AuraHandledException('You do not have access to add new Patient');
                }
            }else{
                system.debug('test Block');
                throw new AuraHandledException('Patient Details are null');
            }    
            return patientWrap;                     
        } 
        catch (System.DmlException ex){
            system.debug('In Catch Block');

             if(ex.getMessage().contains('Medical_Record__c')){

                throw new AuraHandledException('Medical record number is duplicate');

            }
            throw new AuraHandledException(ex.getMessage());
        }   
        catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    /*@AuraEnabled(cacheable=true)
    public static List<Patient__c> fetchPatientInfo(String searchTerm){
        system.debug('searchTerm-->'+searchTerm);
        String query= 'SELECT Id, Name, Patient_First_Name__c, Patient_Middle_Name__c, Patient_Last_Name__c, Patient_Date_of_Birth__c, Patient_Email__c, Gender__c, Marrital_Status__c, Patient_Contact_Phone__c FROM Patient__c';
         if ( searchTerm != Null ) {
            String key = '%' + searchTerm + '%';
            query += ' WHERE Name LIKE :key';
            system.debug('query->'+query);
        }system.debug(Database.query( query ));
         return Database.query( query );
        
    }*/
    
   
    /**
    * @description 
    * @author Bhagyashri Jadhav | 06-08-2022 
    * @param searchTerm 
    * @return List<Patient__c> 
    **/
    @AuraEnabled
    public static List<Patient__c> fetchPatientInfo( String searchTerm ) {
        system.debug('searchTerm-->'+searchTerm);
        try{
            List<Patient__c> patients = new List<Patient__c>();
            if ( String.isNotBlank( searchTerm ) && searchTerm.length() > 1 ) {
                system.debug('test');
                String searchPatients = searchTerm+'%';
                system.debug('searchPatients'+searchPatients);
                patients = [SELECT Id, Name, Patient_First_Name__c, Patient_Middle_Name__c, Patient_Last_Name__c, Patient_Date_of_Birth__c, Patient_Email__c, Gender__c, 
                                   Marrital_Status__c, Patient_Contact_Phone__c,Medical_Record__c FROM Patient__c WHERE Medical_Record__c LIKE :searchPatients ORDER BY Name LIMIT 10];
                system.debug('patients-->'+patients);
                system.debug('patients-->'+JSON.serialize(patients));
            }
            return patients;
        }Catch(Exception e){
            //throw new AuraHandledException('Not able to get Patient records');
            HandleCustomException.LogException(e, 'patientCareServiceController', 'fetchPatientInfo');
           return null;
        }        
    }

    @AuraEnabled
    public static patientPicklstWrapper initPatientForm(){
        try{
            patientPicklstWrapper patientInitObj = new patientPicklstWrapper();
            patientInitObj.picklistLabelAndValues = getPickListValuesIntoList();
            system.debug('Picklist Values->'+patientInitObj);
            return patientInitObj;
        } catch (Exception e){
            HandleCustomException.LogException(e, 'patientCareServiceController', 'initPatientForm');
           // throw new AuraHandledException(e.getMessage());
           return null;
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<Patient_Care_Service__c> getPatientServicesList(Id patientId){
        try{
            List<Patient_Care_Service__c> psList = [SELECT Id, Name, Patient_Message__c, Nursing_Service__c, Patient__c,
                                                        Preferred_day_of_the_week__c, Preferred_time_of_day__c, Service__c, 
                                                        Specialty__c, Supportive_Care__c, Therapy_Service__c,CreatedDate FROM Patient_Care_Service__c
                                                        WHERE Patient__c =:patientId LIMIT 10];

            system.debug('Patient Service List: '+psList);
            return psList;
        }catch (Exception e){
            HandleCustomException.LogException(e, 'patientCareServiceController', 'getPatientServicesList');
           // throw new AuraHandledException(e.getMessage());
           return null;
        }

    }

    public class patientWrapperClass{
        @AuraEnabled 
        public Patient__c patientsInfo{get;set;}
        @AuraEnabled 
        public Patient_Care_Service__c therapypatientCareServices{get;set;}
        @AuraEnabled 
        public Patient_Care_Service__c nursingpatientCareServices{get;set;}
    }

    public class patientPicklstWrapper{
        @AuraEnabled 
        public Map<String,List<String>> picklistLabelAndValues {get;set;}
    }

}

