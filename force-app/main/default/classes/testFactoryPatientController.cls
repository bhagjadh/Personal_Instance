/**
 * @description       : Test data for 
 * @author            : Bhagyashri Jadhav
 * @group             : 
 * @last modified on  : 06-16-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public class testFactoryPatientController {
    public testFactoryPatientController() {

    }

    public static Patient_Form_Picklists__c createCustomSetting() {
        Patient_Form_Picklists__c picklist = new Patient_Form_Picklists__c();
        picklist.Name = 'Gender';
        picklist.Object_Type__c = 'Patient__c';
        picklist.Picklist_Field_Name__c = 'Gender__c';
        insert picklist;
        return picklist;
    }

    public static Patient__c createPatient(){
        Patient__c pt = new Patient__c();
        pt.Patient_First_Name__c = 'Test1';
        pt.Patient_Middle_Name__c ='Test1';
        pt.Patient_Last_Name__c = 'TestLN';
        pt.Patient_Email__c ='test1@g.com';
        pt.Patient_Date_of_Birth__c = system.today();
        pt.Patient_Contact_Phone__c = '987-876-8988';
        pt.Gender__c ='Female';
        pt.Marrital_Status__c = 'Single';
        pt.Medical_Record__c = 'MRN0001';


        return pt;
    }

    public static patientCareServiceController.patientWrapperClass createPatientCareService(Patient__c pt){
        patientCareServiceController.patientWrapperClass testWrap = new patientCareServiceController.patientWrapperClass();
        testWrap.patientsInfo = pt;
        Patient_Care_Service__c therapyService = new Patient_Care_Service__c();
        Id therapyRecordTypeId = [select Id,DeveloperName from RecordType where DeveloperName = 'Therapy_Service' AND sObjectType = 'Patient_Care_Service__c' limit 1].Id;            therapyService.Therapy_Service__c = true;
        therapyService.RecordTypeId = therapyRecordTypeId;
        therapyService.Specialty__c = 'Not Sure';
        therapyService.Patient__c = pt.Id;
        therapyService.Preferred_day_of_the_week__c ='Tuesday';
        therapyService.Preferred_time_of_day__c = Time.newInstance(0,0,0,0);
        therapyService.Patient_Message__c = 'Hi';
        
        testWrap.therapypatientCareServices = therapyService;
        Patient_Care_Service__c nursingService = new Patient_Care_Service__c();
        Id nursingRecordTypeId = [select Id,DeveloperName from RecordType where DeveloperName = 'Nursing_Service' AND sObjectType = 'Patient_Care_Service__c' limit 1].Id;
        nursingService.RecordTypeId = nursingRecordTypeId;
        nursingService.Nursing_Service__c = true;
        nursingService.Supportive_Care__c = 'Personal Care';
        nursingService.Service__c = 'Bone Surgery';
        nursingService.Patient__c = pt.Id;
        nursingService.Preferred_day_of_the_week__c ='Monday';
        nursingService.Preferred_time_of_day__c = Time.newInstance(0,0,0,0);
        
        testWrap.nursingpatientCareServices = nursingService;
        return testWrap;
    }

    public static Profile fetchProfile(String profileName){
        Profile newProfile = [SELECT Id FROM Profile WHERE Name =:profileName];
        return newProfile;
    }

    public static User createUser(Id profileId, String userName){
        String uniqueUser = userName + DateTime.now().getTime() + '@test.com';

        User u = new User(
        Alias = userName, 
        Email= userName+'@test.com',
        EmailEncodingKey='UTF-8', 
        LastName= userName + 'test', 
        LanguageLocaleKey='en_US', 
        LocaleSidKey='en_US', 
        ProfileId = profileId,
        TimeZoneSidKey='America/Los_Angeles', 
        UserName=uniqueUser);

        return u;
    }

    public static User fetchUser(String aliasName){
        User userInfo = [SELECT Id, Alias FROM User WHERE Alias =: aliasName LIMIT 1];
        return userInfo;
    }

}
