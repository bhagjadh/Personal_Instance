/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 06-16-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/

@isTest
public class PatientCareServiceControllerTestClass {
   
@TestSetup
static void createPatientTestData(){
    Profile profileName = testFactoryPatientController.fetchProfile('System Administrator');
    User user = testFactoryPatientController.createUser(profileName.Id,'sysadmin');
    insert user;

    System.runAs(user){
        Profile profilePatientUser = testFactoryPatientController.fetchProfile('Patient Care Service');
        User patinetUser = testFactoryPatientController.createUser(profilePatientUser.Id,'pcare');
        insert patinetUser;

        Patient__c pt = testFactoryPatientController.createPatient();
        insert pt;

        Patient_Form_Picklists__c picklistValues = testFactoryPatientController.createCustomSetting();
        
    }
}

@isTest
static void testPickListValuesIntoList(){
    User patientCareUser = testFactoryPatientController.fetchUser('pcare');

    System.runAs(patientCareUser){
        Map<String, List<String>> options = new  Map<String, List<String>>();
        Test.startTest();
            patientCareServiceController.getPickListValuesIntoList();
            options = patientCareServiceController.getPickListValuesIntoList();
            patientCareServiceController.initPatientForm();
        Test.stopTest();
        System.assertEquals(options.containsKey('Gender'), True,'Gender value is not matched');
    }

}

@isTest
static void testPatientSearch(){
    User patientCareUser = testFactoryPatientController.fetchUser('pcare');
    Patient__c pt = [SELECT Id, Name, Patient_First_Name__c, Medical_Record__c FROM Patient__c WHERE Medical_Record__c = 'MRN0001' ORDER BY Name LIMIT 1];
    System.runAs(patientCareUser){
     Test.startTest();
            patientCareServiceController.fetchPatientInfo(pt.Medical_Record__c);
            patientCareServiceController.getPatientServicesList(pt.Id);
        Test.stopTest();
        System.assertEquals(pt.Patient_First_Name__c, 'Test1','Fisrt Name is not matches');
    }

}

@isTest
static void testGetPatientInfo(){
    User patientCareUser = testFactoryPatientController.fetchUser('pcare');

    System.runAs(patientCareUser){
        Patient__c pt = testFactoryPatientController.createPatient();  
        pt.Medical_Record__c = 'MRN0076';
        patientCareServiceController.patientWrapperClass ps1 = testFactoryPatientController.createPatientCareService(pt);

        Test.startTest();
            patientCareServiceController.getPatientInfo(ps1);
        Test.stopTest();
        System.assertEquals(pt.Patient_First_Name__c, 'Test1','Fisrt Name is not matches');
    }
}

@isTest
static void testGetPatientInfoDataAsNull(){
    User patientCareUser = testFactoryPatientController.fetchUser('pcare');

    System.runAs(patientCareUser){
        Patient__c pt = testFactoryPatientController.createPatient();  
        pt.Medical_Record__c = 'MRN0003';
        patientCareServiceController.patientWrapperClass ps1 = testFactoryPatientController.createPatientCareService(pt);
        try{
            patientCareServiceController.getPatientInfo(null);
        }
        catch (Exception e){
        }
    }
}
}
