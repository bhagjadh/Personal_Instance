({

    setPicklistValues : function(component, event) {
        const action = component.get("c.initPatientForm");
        action.setCallback(this,function(response){
            let state = response.getState();
            if(state === "SUCCESS"){
                var serverResponse = response.getReturnValue();
                var picklistValueResult = serverResponse.picklistLabelAndValues;
                var returnKeyValues = Object.keys(picklistValueResult);
                component.set("v.picklistMap",picklistValueResult);

                for(var identifierKey of returnKeyValues){
                      let pickLIstOptions = picklistValueResult[identifierKey];
                        var items = [];
                        pickLIstOptions.forEach((i) => {
                            var item ={
                                "label" : i,
                                "value" : i
                            };
                            items.push(item);
                        });
                        component.set("v.options"+identifierKey,items);
                }           

            }
        });
        $A.enqueueAction(action);

    },

    isDataValid : function(component, event){
        var patientFields = ['medicalRecord', 'patientFirstName', 'patientMiddleName', 'patientLastName', 'patientDOB',
                             'patientEmail', 'patientContact','Gender','Marrital_Status'];

        if(component.get("v.patientTherapyServiceInfo.Therapy_Service__c")){
            patientFields.push('Specialty', 'Preferred_day_of_the_week', 'patientPrefTimeOfWeek');
        }

        if(component.get("v.patientNursingServiceInfo.Nursing_Service__c")){
            patientFields.push('Supportive_Care', 'Service', 'Nurse_Preferred_day_of_the_week', 'NursepatientPrefTimeOfWeek');
        }

        var valid = true;

        for(let patientFieldsString of patientFields){
            let inputElement = component.find(patientFieldsString);
            if(! inputElement.get("v.validity").valid){
                inputElement.reportValidity();
                valid = false;
            }
        }

        if(! valid){
            let notifVariant = "error";
            let notifTitle = "Error!"
            let notifMessage= "Fill the required information and try again.";
            let notifMessageData = "";
            this.handleShowToast(component, notifVariant, notifTitle, notifMessage, notifMessageData);
        }
        return valid;
    },

	savePatientInfo : function(component, event, patientDetails) {
        if(this.isDataValid(component)){
            
            var action = component.get("c.getPatientInfo");
            action.setParams({
                patientWrap : patientDetails,
                });
            action.setCallback(this,function(response){
                var state = response.getState();
                
                if(state === "SUCCESS"){
                    var result = response.getReturnValue();
                var recordId = result.patientsInfo.Id;
                    let notifVariant = "success";
                    let notifTitle = "Success!"
                    let notifMessage= "{0} record {1} added successfully!.";
                    let notifMessageData = ['Patient',
                                            {
                                                url :$A.get("$Label.c.Patient_Record_URL")+ recordId+'/view',
                                                label : result.patientsInfo.Medical_Record__c,
                                            }];
                    this.handleShowToast(component, notifVariant, notifTitle, notifMessage, notifMessageData);
                    this.resetInputForm(component);

                } else if(state === "ERROR"){
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                           let notifVariant = "error";
                           let notifTitle = "Error!"
                           let notifMessage= errors[0].message;
                           let notifMessageData = "";

                           this.handleShowToast(component, notifVariant, notifTitle, notifMessage, notifMessageData);
                        }
                    }else{
                        let notifVariant = "error";
                        let notifTitle = "Error!"
                        let notifMessage= "Unknown problem has occured";
                        let notifMessageData = "";
                        this.handleShowToast(component, notifVariant, notifTitle, notifMessage, notifMessageData);
                    }
                    this.handleShowToast(component, notifVariant, notifTitle, notifMessage, notifMessageData);
                }
            });       
            $A.enqueueAction(action);  
        }else{
            let notifVariant = "error";
            let notifTitle = "Error!"
            let notifMessage= "Fill the required information and try again.";
            let notifMessageData = "";
            this.handleShowToast(component, notifVariant, notifTitle, notifMessage, notifMessageData);
        }

    },

    handleShowToast : function(component, variant, title, message, messageData){
        component.find('notifLib').showToast({
            variant,
            title,
            message,
            messageData
        });
    },

    resetInputForm : function(component){
        component.set("v.patientInfo",{ 'SobjectType': 'Patient__c', 
        'Patient_First_Name__c': '',
        'Patient_Middle_Name__c': '',
        'Patient_Last_Name__c': '',
        'Patient_Date_of_Birth__c': '',
        'Patient_Email__c': '',
        'Patient_Contact_Phone__c': '',
        'Medical_Record__c': '',
        'Gender__c': '',
        'Marrital_Status__c': ''});
    
        component.set("v.patientTherapyServiceInfo",{ 'SobjectType': 'Patient_Care_Service__c', 
            'Specialty__c	': '',
            'Preferred_day_of_the_week__c': '',
            'Preferred_time_of_day__c': '',
            'Patient_Message__c': ''});
        
        component.set("v.patientNursingServiceInfo",{ 'SobjectType': 'Patient_Care_Service__c', 
            'Supportive_Care__c': '',
            'Service__c	': '',
            'Preferred_day_of_the_week__c': '',
            'Preferred_time_of_day__c': ''});
    },  

    valueChange: function(component,event){
        if(event.getSource().get("v.name") === 'gender'){
            let selectedOptionValue = event.getParam( "value" );
            component.set("v.patientInfo.Gender__c",selectedOptionValue);
        }

        if(event.getSource().get("v.name") === 'marrital_Status'){
            let selectedOptionValue = event.getParam( "value" );
            component.set("v.patientInfo.Marrital_Status__c",selectedOptionValue);
        }

        if(event.getSource().get("v.name") === 'specialty'){
            let selectedSpecialty = event.getParam( "value" );
            component.set("v.patientTherapyServiceInfo.Specialty__c",selectedSpecialty);
        }

        if(event.getSource().get("v.name") === 'PrefDayOfTheWeek'){
            let selectedPrefDayOfTheWeek = event.getParam( "value" );
            component.set("v.patientTherapyServiceInfo.Preferred_day_of_the_week__c",selectedPrefDayOfTheWeek);
        }


        if(event.getSource().get("v.name") === 'Supportive_Care'){
            let selectedOptionValue = event.getParam( "value" );
            component.set("v.patientNursingServiceInfo.Supportive_Care__c",selectedOptionValue);
        }
        
        if(event.getSource().get("v.name") === 'Service'){
            let selectedOptionValue = event.getParam( "value" );
            component.set("v.patientNursingServiceInfo.Service__c",selectedOptionValue);
        }

        if(event.getSource().get("v.name") === 'NursePrefDayOfTheWeek'){
            let selectedOptionValue = event.getParam( "value" );
            component.set("v.patientNursingServiceInfo.Preferred_day_of_the_week__c",selectedOptionValue);
        }
        
    }
})